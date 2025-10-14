#ifndef WIFIMODEL_H
#define WIFIMODEL_H

#include "WiFiViewModel.h"
#include <QObject>

class WiFiModel : public QObject
{
    Q_OBJECT
public:
    explicit WiFiModel(QObject *parent = nullptr);

signals:

private:
    WiFiViewModel* m_model;
};

#endif // WIFIMODEL_H
