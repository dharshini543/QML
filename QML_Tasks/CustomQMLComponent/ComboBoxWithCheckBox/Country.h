#ifndef COUNTRY_H
#define COUNTRY_H
#include<QString>

class Country
{
public:
    Country(QString countryName,QString countryImage);

    QString getCountryName() const;
    void setCountryName(const QString &newCountryName);

    QString getCountryImage() const;
    void setCountryImage(const QString &newCountryImage);

private:
    QString m_countryName;
    QString m_countryImage;
};

#endif // COUNTRY_H
