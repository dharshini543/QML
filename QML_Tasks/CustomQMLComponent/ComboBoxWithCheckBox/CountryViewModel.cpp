#include "CountryViewModel.h"
#include <QFile>
#include <QXmlStreamReader>
#include <QList>
#include <QString>
#include <QDebug>
#include<QDir>

CountryViewModel::CountryViewModel(QObject *parent)
    : QAbstractListModel{parent}
{
    loadCountriesFromXml();
}

void CountryViewModel::loadCountriesFromXml()
{
    QString filePath = QDir::currentPath() + "/Countries.xml";
    QFile file(filePath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open file:" << filePath;
        return;
    }

    QXmlStreamReader xml(&file);

    beginResetModel();
    m_countryList.clear();

    while (!xml.atEnd() && !xml.hasError()) {
        QXmlStreamReader::TokenType token = xml.readNext();
        if (token == QXmlStreamReader::StartElement && xml.name() == "Country") {
            QString countryName = xml.readElementText();
            QString countryImage = xml.readElementText();
            m_countryList.push_back(Country(countryName, countryImage));
        }
    }
    endResetModel();

    file.close();
}
int CountryViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_countryList.size();
}

QVariant CountryViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_countryList.size())
        return QVariant();

    const Country net = m_countryList[index.row()];

    switch (role)
    {
    case CountryName:
        return net.getCountryName();
    case CountryImage:
        return net.getCountryImage();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> CountryViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CountryName] = "CountryName";
    roles[CountryImage] = "CountryImage";
    return roles;
}
