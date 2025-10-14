#ifndef WIFIDATAMODEL_H
#define WIFIDATAMODEL_H

#include "WiFiNetwork.h"
#include<QList>
#include<QMap>

class WiFiDataModel
{
public:
    WiFiDataModel();
    ~WiFiDataModel();

    void loadFromCSV();
    bool connectToNetwork(const QString &wifiName, const QString &enteredPassword);
    QList<WiFiNetwork> getAllNetworks() const;
    void sortNetworks();

private:
    QMap<QString, QList<WiFiNetwork>> m_groupedNetworks;
};

#endif // WIFIDATAMODEL_H

