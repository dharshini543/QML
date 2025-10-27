#ifndef COUNTRIES_H
#define COUNTRIES_H

#include <QAbstractListModel>
#include <QObject>

class Countries : public QAbstractListModel
{
    // QAbstractItemModel interface
public:
    explicit Countries(QObject *parent = nullptr);

    void loadCountriesFromXml();
    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    enum country
    {
        CountryName = 1
    };

private:
    QStringList m_countryList;
};

#endif // COUNTRIES_H
