#ifndef WIFIVIEWMODEL_H
#define WIFIVIEWMODEL_H

#include "WiFiDataModel.h"
#include <QAbstractListModel>

class WiFiViewModel : public QAbstractListModel
{
    Q_OBJECT

    // QAbstractItemModel interface
public:
    explicit WiFiViewModel(QObject *parent = nullptr);
    ~WiFiViewModel();

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE bool connectToNetwork(const QString &wifiName, const QString &password);
    Q_INVOKABLE void refreshModel();

    enum WiFi
    {
        WiFiName = 1,
        WiFiPassword,
        WiFiStatus,
        SignalStrength
    };

private:
    WiFiDataModel* m_dataModel;
    QList<WiFiNetwork> m_currentList;
};

#endif // WIFIVIEWMODEL_H



