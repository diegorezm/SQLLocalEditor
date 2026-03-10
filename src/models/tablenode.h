#ifndef TABLENODE_H
#define TABLENODE_H

#include <QString>
#include <QList>
#include "column.h"
#include "foreignkey.h"

struct TableNode {
    QString           name;
    QList<Column>     columns;
    QList<ForeignKey> foreignKeys;
    float             x = 0;
    float             y = 0;
};

#endif
