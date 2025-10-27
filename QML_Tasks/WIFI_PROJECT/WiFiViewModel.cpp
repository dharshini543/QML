// #include "WiFiViewModel.h"

// WiFiViewModel::WiFiViewModel(QObject *parent)
//     : QAbstractListModel(parent),
//     m_dataModel(new WiFiDataModel)
// {
//     m_dataModel->loadFromCSV();
//     refreshModel();
// }

// WiFiViewModel::~WiFiViewModel()
// {
//     m_dataModel->saveToCSV();
//     delete m_dataModel;
// }

// int WiFiViewModel::rowCount(const QModelIndex &parent) const
// {
//     Q_UNUSED(parent)
//     return m_currentList.size();
// }

// QVariant WiFiViewModel::data(const QModelIndex &index, int role) const
// {
//     if (!index.isValid() || index.row() >= m_currentList.size())
//         return QVariant();

//     const WiFiNetwork &net = m_currentList[index.row()];

//     switch (role)
//     {
//     case WiFiName:
//         return net.getWifiName();
//     case WiFiPassword:
//         return net.getWifiPassword();
//     case WiFiStatus:
//         return net.getWifiStatus();
//     case SignalStrength:
//         return net.getSignalStrength();
//     default:
//         return QVariant();
//     }
// }

// QHash<int, QByteArray> WiFiViewModel::roleNames() const
// {
//     QHash<int, QByteArray> roles;
//     roles[WiFiName] = "WiFiName";
//     roles[WiFiPassword] = "WiFiPassword";
//     roles[WiFiStatus] = "WiFiStatus";
//     roles[SignalStrength] = "SignalStrength";
//     return roles;
// }

// bool WiFiViewModel::connectToNetwork(const QString &wifiName, const QString &password)
// {
//     bool Ok = m_dataModel->connectToNetwork(wifiName, password);
//     refreshModel();
//     return Ok;

// }

// void WiFiViewModel::filterByName(const QString &query)
// {
//     beginResetModel();
//     m_filteredNetworks.clear();

//     QString q = query.trimmed().toLower();
//     if (q.isEmpty()) {
//         m_filteredNetworks = m_currentList;
//     } else {
//         for (const auto &net : m_currentList) {
//             if (net.getWifiName().toLower().contains(q))
//                 m_filteredNetworks.append(net);
//         }
//     }

//     endResetModel();
// }
// void WiFiViewModel::refreshModel()
// {
//     beginResetModel();
//     m_currentList = m_dataModel->getAllNetworks();
//     m_filteredNetworks = m_currentList;
//     endResetModel();
// }


#include "WiFiViewModel.h"
#include <algorithm>

WiFiViewModel::WiFiViewModel(QObject *parent)
    : QAbstractListModel(parent), m_dataModel(new WiFiDataModel)
{
    m_dataModel->loadFromCSV();
    refreshModel();
}

WiFiViewModel::~WiFiViewModel()
{
    m_dataModel->saveToCSV();
    delete m_dataModel;
}

int WiFiViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_filteredNetworks.size();
}

QVariant WiFiViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_filteredNetworks.size())
        return QVariant();

    const WiFiNetwork &net = m_filteredNetworks.at(index.row());

    switch (role) {
    case WiFiName: return net.getWifiName();
    case WiFiPassword: return net.getWifiPassword();
    case WiFiStatus: return net.getWifiStatus();
    case SignalStrength: return net.getSignalStrength();
    default: return QVariant();
    }
}

QHash<int, QByteArray> WiFiViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[WiFiName] = "WiFiName";
    roles[WiFiPassword] = "WiFiPassword";
    roles[WiFiStatus] = "WiFiStatus";
    roles[SignalStrength] = "SignalStrength";
    return roles;
}

bool WiFiViewModel::connectToNetwork(const QString &wifiName, const QString &password)
{
    bool ok = m_dataModel->connectToNetwork(wifiName, password);
    refreshModel();
    return ok;
}

void WiFiViewModel::refreshModel()
{
    beginResetModel();
    m_currentList = m_dataModel->getAllNetworks();
    m_filteredNetworks = m_currentList;
    endResetModel();
}

void WiFiViewModel::filterByName(const QString &query)
{
    beginResetModel();

    QString userEntry = query.trimmed().toLower();
    if (userEntry.isEmpty())
    {
        m_filteredNetworks = m_currentList;
    }
    else
    {
        QList<WiFiNetwork> prefixMatches;
        QList<WiFiNetwork> containsMatches;

        for (const auto &net : m_currentList)
        {
            QString name = net.getWifiName().toLower();
            if (name.startsWith(userEntry))
            {
                prefixMatches.append(net);
            }
            else if (name.contains(userEntry))
            {
                containsMatches.append(net);
            }
        }

        auto sortFn = [](const WiFiNetwork &a, const WiFiNetwork &b)
        {
            return a.getWifiName().toLower() < b.getWifiName().toLower();
        };
        std::sort(prefixMatches.begin(), prefixMatches.end(), sortFn);
        std::sort(containsMatches.begin(), containsMatches.end(), sortFn);

        m_filteredNetworks = prefixMatches + containsMatches;
    }
    endResetModel();
}
