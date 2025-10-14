#include "WiFiViewModel.h"

WiFiViewModel::WiFiViewModel(QObject *parent)
    : QAbstractListModel(parent),
    m_dataModel(new WiFiDataModel)
{
    qDebug()<<Q_FUNC_INFO;
    m_dataModel->loadFromCSV();
    refreshModel();
}

WiFiViewModel::~WiFiViewModel()
{
    delete m_dataModel;
}

int WiFiViewModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_currentList.size();
}

QVariant WiFiViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_currentList.size())
        return QVariant();

    const WiFiNetwork &net = m_currentList[index.row()];

    switch (role)
    {
    case WiFiName:
        return net.getWifiName();
    case WiFiPassword:
        return net.getWifiPassword();
    case WiFiStatus:
        return net.getWifiStatus();
    case SignalStrength:
        return net.getSignalStrength();
    default:
        return QVariant();
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
    bool Ok = m_dataModel->connectToNetwork(wifiName, password);
    refreshModel();
    return Ok;
}

void WiFiViewModel::refreshModel()
{
    beginResetModel();
    m_currentList = m_dataModel->getAllNetworks();
    endResetModel();
}
