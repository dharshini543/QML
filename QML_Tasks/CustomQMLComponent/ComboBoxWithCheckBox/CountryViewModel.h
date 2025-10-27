#ifndef COUNTRYVIEWMODEL_H
#define COUNTRYVIEWMODEL_H

#include "Country.h"
#include <QAbstractListModel>
#include <QObject>

class CountryViewModel : public QAbstractListModel
{
    // QAbstractItemModel interface
public:
    explicit CountryViewModel(QObject *parent = nullptr);

    void loadCountriesFromXml();
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    enum country
    {
        CountryName = 1,
        CountryImage
    };

private:
    QList<Country> m_countryList;
};


#endif // COUNTRYVIEWMODEL_H
