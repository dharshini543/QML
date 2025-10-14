#include "WiFiDataModel.h"
#include "qdebug.h"
#include <QProcess>
#include <QStringList>
#include <algorithm>

WiFiDataModel::WiFiDataModel()
{
    qDebug()<<Q_FUNC_INFO;
}


WiFiDataModel::~WiFiDataModel()
{

}

void WiFiDataModel::loadFromCSV()
{
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Home Wi-Fi", "123", "unsaved", 10));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Office", "123", "unsaved", 20));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("CafeZone", "123", "unsaved", 35));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Library", "123", "unsaved", 0));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Dharshini", "123", "unsaved", 55));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Likitha", "123", "unsaved", 60));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Dhimanth", "123", "unsaved", 80));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Girish", "123", "unsaved", 92));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Vidya", "123", "unsaved", 100));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Pallavi", "123", "unsaved", 45));
    // m_groupedNetworks["unsaved"].append(WiFiNetwork("Varshini", "123", "unsaved", 100));

    // sortNetworks();

    m_groupedNetworks["unsaved"].clear(); // clear old list

    QProcess process;
    process.start("bash", QStringList() << "-c" << "nmcli -t -f SSID,SIGNAL dev wifi list");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();

    QStringList lines = output.split("\n", Qt::SkipEmptyParts);
    for (const QString &line : lines)
    {
        QStringList parts = line.split(":");
        if (parts.size() >= 2)
        {
            QString ssid = parts[0].trimmed();
            int signal = parts[1].toInt();
            if (!ssid.isEmpty())
            {
                m_groupedNetworks["unsaved"].append(WiFiNetwork(ssid, "123", "unsaved", signal));
            }
        }
    }
}


bool WiFiDataModel::connectToNetwork(const QString &wifiName, const QString &enteredPassword)
{
    for (const QString &key : m_groupedNetworks.keys())
    {
        qDebug()<<key;
        QList<WiFiNetwork> &groupList = m_groupedNetworks[key];
        qDebug()<<groupList.size();

        int index = -1;
        for (int i = 0; i < groupList.size(); ++i)
        {
            if (groupList[i].getWifiName() == wifiName)
            {
                index = i;
                break;
            }
        }

        if (index != -1)
        {
            if (groupList[index].getWifiPassword() != enteredPassword)
                return false;

            for (WiFiNetwork &n : m_groupedNetworks["connected"])
            {
                n.setWifiStatus("saved");
                m_groupedNetworks["saved"].append(n);
            }
            m_groupedNetworks["connected"].clear();

            WiFiNetwork connected = groupList.takeAt(index);
            connected.setWifiStatus("connected");
            m_groupedNetworks["connected"].append(connected);

            sortNetworks();
            return true;
        }
    }
    return false;
}


void WiFiDataModel::sortNetworks()
{
    auto sortBySignal = [](const WiFiNetwork &a, const WiFiNetwork &b) {
        return a.getSignalStrength() > b.getSignalStrength();
    };
    std::sort(m_groupedNetworks["saved"].begin(), m_groupedNetworks["saved"].end(), sortBySignal);
    std::sort(m_groupedNetworks["unsaved"].begin(), m_groupedNetworks["unsaved"].end(), sortBySignal);
}

QList<WiFiNetwork> WiFiDataModel::getAllNetworks() const
{
    QList<WiFiNetwork> result;
    if (m_groupedNetworks.contains("connected"))
    {
        result += m_groupedNetworks.value("connected");
    }
    if (m_groupedNetworks.contains("saved"))
    {
        result += m_groupedNetworks.value("saved");
    }
    if (m_groupedNetworks.contains("unsaved"))
    {
        result += m_groupedNetworks.value("unsaved");
    }
    return result;

}


