#ifndef SCHEMAMODEL_H
#define SCHEMAMODEL_H

#include "tablenode.h"
#include <QAbstractListModel>
#include <QList>
#include <QVariantList>

class SchemaModel : public QAbstractListModel {
  Q_OBJECT

public:
  enum SchemaRole {
    NameRole = Qt::UserRole + 1,
    XRole,
    YRole,
    ColumnsRole,
    ForeignKeysRole,
  };

  explicit SchemaModel(QObject *parent = nullptr);

  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
  QVariant data(const QModelIndex &index,
                int role = Qt::DisplayRole) const override;
  QHash<int, QByteArray> roleNames() const override;

  // called from QML
  Q_INVOKABLE void addTable(const QString &name, float x, float y);
  Q_INVOKABLE void removeTable(int index);
  Q_INVOKABLE void renameTable(int index, const QString &name);
  Q_INVOKABLE void moveTable(int index, float x, float y);

  // column operations
  Q_INVOKABLE void addColumn(int tableIndex, const QString &name, int type);
  Q_INVOKABLE void removeColumn(int tableIndex, int columnIndex);

  // foreign key operations
  Q_INVOKABLE void addForeignKey(const QString &fromTable,
                                 const QString &fromColumn,
                                 const QString &toTable,
                                 const QString &toColumn);
  Q_INVOKABLE void removeForeignKey(int tableIndex, int fkIndex);

  // returns the full list of tables (for SQL generation)
  const QList<TableNode> &tables() const;

private:
  QList<TableNode> m_tables;

  QVariantList columnsToVariant(const QList<Column> &columns) const;
  QVariantList foreignKeysToVariant(const QList<ForeignKey> &fks) const;
};

#endif
