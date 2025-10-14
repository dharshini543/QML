#ifndef WIFINETWORK_H
#define WIFINETWORK_H
#include<QString>

class WiFiNetwork
{
public:
    WiFiNetwork(QString wifiName, QString wifiPassword, QString wifiStatus, int signalStrength);
    ~WiFiNetwork();

    QString getWifiName() const;
    void setWifiName(const QString &newWifiName);

    QString getWifiPassword() const;
    void setWifiPassword(const QString &newWifiPassword);

    QString getWifiStatus() const;
    void setWifiStatus(const QString &newWifiStatus);

    int getSignalStrength() const;
    void setSignalStrength(int newSignalStrength);

private:
    QString m_wifiName;
    QString m_wifiPassword;
    QString m_wifiStatus;
    int m_signalStrength;
};

#endif // WIFINETWORK_H
