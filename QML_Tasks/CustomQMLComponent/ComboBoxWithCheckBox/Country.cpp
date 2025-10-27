#include "Country.h"

Country::Country(QString countryName,QString countryImage)
{
    m_countryName = countryName;
    m_countryImage = countryImage;
}

QString Country::getCountryName() const
{
    return m_countryName;
}

void Country::setCountryName(const QString &newCountryName)
{
    m_countryName = newCountryName;
}

QString Country::getCountryImage() const
{
    return m_countryImage;
}

void Country::setCountryImage(const QString &newCountryImage)
{
    m_countryImage = newCountryImage;
}
