#include "WiFiNetwork.h"
#include "qdebug.h"

WiFiNetwork::WiFiNetwork(QString wifiName, QString wifiPassword, QString wifiStatus, int signalStrength)
{
    m_wifiName = wifiName;
    m_wifiPassword = wifiPassword;
    m_wifiStatus = wifiStatus;
    m_signalStrength = signalStrength;
}

WiFiNetwork::~WiFiNetwork()
{
}

QString WiFiNetwork::getWifiName() const
{
    return m_wifiName;
}

void WiFiNetwork::setWifiName(const QString &newWifiName)
{
    m_wifiName = newWifiName;
}

QString WiFiNetwork::getWifiPassword() const
{
    return m_wifiPassword;
}

void WiFiNetwork::setWifiPassword(const QString &newWifiPassword)
{
    m_wifiPassword = newWifiPassword;
}

QString WiFiNetwork::getWifiStatus() const
{
    return m_wifiStatus;
}

void WiFiNetwork::setWifiStatus(const QString &newWifiStatus)
{
    m_wifiStatus = newWifiStatus;
}

int WiFiNetwork::getSignalStrength() const
{
    return m_signalStrength;
}

void WiFiNetwork::setSignalStrength(int newSignalStrength)
{
    m_signalStrength = newSignalStrength;
}




