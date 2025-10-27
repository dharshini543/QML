#include "WiFiDataModel.h"
#include "qdebug.h"
#include <QProcess>
#include <QStringList>
#include <algorithm>
#include<QDir>

WiFiDataModel::WiFiDataModel()
{

}

WiFiDataModel::~WiFiDataModel()
{

}

// void WiFiDataModel::loadFromCSV()
// {
//     QProcess process;
//     process.start("bash", QStringList() << "-c" << "nmcli -t -f SSID,SIGNAL dev wifi list");
//     process.waitForFinished();
//     QString output = process.readAllStandardOutput();

//     QStringList lines = output.split("\n", Qt::SkipEmptyParts);
//     for (const QString &line : lines)
//     {
//         QStringList parts = line.split(":");
//         if (parts.size() >= 2)
//         {
//             QString ssid = parts[0].trimmed();
//             int signal = parts[1].toInt();
//             if (!ssid.isEmpty())
//             {
//                 m_groupedNetworks["unsaved"].append(WiFiNetwork(ssid, "123", "unsaved", signal));
//             }
//         }
//     }

// }


void WiFiDataModel::loadFromCSV()
{
    qDebug()<<Q_FUNC_INFO;

    QString filePath = QDir::currentPath() + "/WiFiNetworks.csv";
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qWarning() << "Could not open file for reading:" << filePath;
        return;
    }

    QTextStream in(&file);

    m_groupedNetworks.clear();

    while (!in.atEnd())
    {
        QString line = in.readLine().trimmed();
        if (line.isEmpty())
            continue;

        QStringList fields = line.split(",");
        if (fields.size() != 4)
            continue;

        QString ssid = fields[0];
        QString password = fields[1];
        QString status = fields[2];
        int signal = fields[3].toInt();

        m_groupedNetworks[status].append(WiFiNetwork(ssid, password, status, signal));
    }

    file.close();
    sortNetworks();
}

void WiFiDataModel::saveToCSV()
{
    QString filePath = QDir::currentPath() + "/WiFiNetworks.csv";
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qWarning() << "Could not open file for writing:" << filePath;
        return;
    }

    QTextStream out(&file);

    for (auto it = m_groupedNetworks.begin(); it != m_groupedNetworks.end(); ++it)
    {
        const QString &status = it.key();
        const QList<WiFiNetwork> &networks = it.value();

        for (const WiFiNetwork &network : networks)
        {
            out << network.getWifiName() << ","
                << network.getWifiPassword() << ","
                << network.getWifiStatus()<<","
                << network.getSignalStrength() << "\n";
        }
    }

    file.close();
}


bool WiFiDataModel::connectToNetwork(const QString &wifiName, const QString &enteredPassword)
{
    for (const QString &key : m_groupedNetworks.keys())
    {
        QList<WiFiNetwork> &groupList = m_groupedNetworks[key];

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
        result  = result + m_groupedNetworks.value("connected");
    }
    if (m_groupedNetworks.contains("saved"))
    {
        result = result +  m_groupedNetworks.value("saved");
    }
    if (m_groupedNetworks.contains("unsaved"))
    {
        result = result + m_groupedNetworks.value("unsaved");
    }
    return result;

}


