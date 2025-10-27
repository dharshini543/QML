#include "Countries.h"
#include <QFile>
#include <QXmlStreamReader>
#include <QList>
#include <QString>
#include <QDebug>
#include<QDir>

Countries::Countries(QObject *parent)
    : QAbstractListModel{parent}
{
    loadCountriesFromXml();
}

void Countries::loadCountriesFromXml()
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
            m_countryList.append(countryName);
        }
    }

    endResetModel();

    file.close();
}
int Countries::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_countryList.size();
}

QVariant Countries::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_countryList.size())
        return QVariant();

    QString net = m_countryList[index.row()];

    switch (role)
    {
    case CountryName:
        return net;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> Countries::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CountryName] = "CountryName";
    return roles;
}
