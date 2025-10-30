#include "Country.h"

Country::Country(QObject *parent)
    : QObject{parent}
{}

QString Country::getCountryName() const
{
    return m_countryName;
}

void Country::setCountryName(const QString &newCountryName)
{
    if (m_countryName == newCountryName)
        return;
    m_countryName = newCountryName;
    emit countryNameChanged();
}

QString Country::getCountryFlag() const
{
    return m_countryFlag;
}

void Country::setCountryFlag(const QString &newCountryFlag)
{
    if (m_countryFlag == newCountryFlag)
        return;
    m_countryFlag = newCountryFlag;
    emit countryFlagChanged();
}
