#include "CountryViewModel.h"
#include <QFile>
#include <QXmlStreamReader>
#include <QDebug>
#include <QFile>
#include <QDebug>


CountryViewModel::CountryViewModel(QObject *parent)
    : QAbstractListModel{parent}
{
    this->    readCountriesFromFile("Countries.xml");
    for(auto i : m_countryList)
    {
        qDebug()<<"Country : "<<i->getCountryName();
        qDebug()<<"Image : "<<i->getCountryFlag();
    }
}

int CountryViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_countryList.size();
}

QVariant CountryViewModel::data(const QModelIndex &index, int role) const
{
    Country *country = m_countryList.at(index.row());
    switch (role) {
    case COUNTRYNAME:
        return country->getCountryName();
    case COUNTRYFLAG:
        return country->getCountryFlag();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> CountryViewModel::roleNames() const
{
    QHash<int, QByteArray> l_roleNames;
    l_roleNames.insert(COUNTRYNAME, "COUNTRYNAME");
    l_roleNames.insert(COUNTRYFLAG,"COUNTRYFLAG");
    return l_roleNames;
}


// void CountryViewModel::readCountriesFromFile(const QString &filePath)
// {
//     // Clear existing list
//     qDeleteAll(m_countryList);
//     m_countryList.clear();

//     QFile file(filePath);
//     if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//         qWarning() << "❌ Cannot open file:" << filePath;
//         return;
//     }

//     QJsonDocument doc;
//     if (!doc.setContent(&file)) {
//         qWarning() << "❌ Failed to parse XML file:" << filePath;
//         file.close();
//         return;
//     }
//     file.close();

//     QDomElement root = doc.documentElement(); // <countries>
//     if (root.tagName() != "countries") {
//         qWarning() << "❌ Root element is not <countries>";
//         return;
//     }

//     QDomNodeList countryNodes = root.elementsByTagName("country");
//     for (int i = 0; i < countryNodes.count(); ++i) {
//         QDomNode node = countryNodes.at(i);
//         if (node.isElement()) {
//             QDomElement elem = node.toElement();
//             QString name = elem.firstChildElement("name").text();
//             QString flag = elem.firstChildElement("flag").text();

//             if (!name.isEmpty() && !flag.isEmpty()) {
//                 Country* country = new Country();
//                 country->setCountryName(name);
//                 country->setCountryFlag(flag);
//                 m_countryList.append(country);
//             }
//         }
//     }
// }


void CountryViewModel::readCountriesFromFile(const QString &filePath)
{
    qDeleteAll(m_countryList);
    m_countryList.clear();

    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "❌ Cannot open file:" << filePath;
        return;
    }

    QXmlStreamReader xml(&file);

    while (!xml.atEnd() && !xml.hasError()) {
        xml.readNext();

        if (xml.isStartElement() && xml.name() == "country") {
            QString name;
            QString flag;

            while (!(xml.isEndElement() && xml.name() == "country")) {
                xml.readNext();
                if (xml.isStartElement()) {
                    if (xml.name() == "name")
                        name = xml.readElementText();
                    else if (xml.name() == "flag")
                        flag = xml.readElementText();
                }
            }

            if (!name.isEmpty() && !flag.isEmpty()) {
                Country *country = new Country();
                country->setCountryName(name);
                country->setCountryFlag(flag);
                m_countryList.append(country);
            }
        }
    }

    if (xml.hasError()) {
        qWarning() << "❌ XML Parse Error:" << xml.errorString();
    }

    file.close();
}
