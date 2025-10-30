#ifndef MYCOUNTRY_H
#define MYCOUNTRY_H

#include <QObject>

class Country : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString countryName READ getCountryName WRITE setCountryName NOTIFY countryNameChanged FINAL)
    Q_PROPERTY(QString countryFlag READ getCountryFlag WRITE setCountryFlag NOTIFY countryFlagChanged FINAL)
public:
    explicit Country(QObject *parent = nullptr);

    QString getCountryName() const;
    void setCountryName(const QString &newCountryName);

    QString getCountryFlag() const;
    void setCountryFlag(const QString &newCountryFlag);

private:
    QString m_countryName;
    QString m_countryFlag;


signals:
    void countryNameChanged();
    void countryFlagChanged();
};

#endif // MYCOUNTRY_H
