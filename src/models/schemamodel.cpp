#include "schemamodel.h"

SchemaModel::SchemaModel(QObject *parent) : QAbstractListModel(parent) {}

int SchemaModel::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent)
  return m_tables.size();
}

QVariant SchemaModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid() || index.row() >= m_tables.size())
    return QVariant();

  const TableNode &table = m_tables.at(index.row());

  switch (role) {
  case NameRole:
    return table.name;
  case XRole:
    return table.x;
  case YRole:
    return table.y;
  case ColumnsRole:
    return columnsToVariant(table.columns);
  case ForeignKeysRole:
    return foreignKeysToVariant(table.foreignKeys);
  default:
    return QVariant();
  }
}

QHash<int, QByteArray> SchemaModel::roleNames() const {
  return {
      {NameRole, "name"},
      {XRole, "tableX"},
      {YRole, "tableY"},
      {ColumnsRole, "columns"},
      {ForeignKeysRole, "foreignKeys"},
  };
}

void SchemaModel::addTable(const QString &name, float x, float y) {
  beginInsertRows(QModelIndex(), m_tables.size(), m_tables.size());
  TableNode node;
  node.name = name;
  node.x = x;
  node.y = y;
  m_tables.append(node);
  endInsertRows();
}

void SchemaModel::removeTable(int index) {
  if (index < 0 || index >= m_tables.size())
    return;
  beginRemoveRows(QModelIndex(), index, index);
  m_tables.removeAt(index);
  endRemoveRows();
}

void SchemaModel::renameTable(int index, const QString &name) {
  if (index < 0 || index >= m_tables.size())
    return;
  m_tables[index].name = name;
  emit dataChanged(this->index(index), this->index(index), {NameRole});
}

void SchemaModel::moveTable(int index, float x, float y) {
  if (index < 0 || index >= m_tables.size())
    return;
  m_tables[index].x = x;
  m_tables[index].y = y;
  emit dataChanged(this->index(index), this->index(index), {XRole, YRole});
}

void SchemaModel::addColumn(int tableIndex, const QString &name, int type) {
  if (tableIndex < 0 || tableIndex >= m_tables.size())
    return;
  Column col;
  col.name = name;
  col.type = static_cast<ColumnType>(type);
  m_tables[tableIndex].columns.append(col);
  emit dataChanged(this->index(tableIndex), this->index(tableIndex),
                   {ColumnsRole});
}

void SchemaModel::renameColumn(int tableIndex, int columnIndex,
                               const QString &name) {
  if (tableIndex < 0 || tableIndex >= m_tables.size())
    return;
  auto &cols = m_tables[tableIndex].columns;
  if (columnIndex < 0 || columnIndex >= cols.size())
    return;
  cols[columnIndex].name = name;
  emit dataChanged(this->index(tableIndex), this->index(tableIndex),
                   {ColumnsRole});
}

void SchemaModel::setColumnType(int tableIndex, int columnIndex, int type) {
  if (tableIndex < 0 || tableIndex >= m_tables.size())
    return;
  auto &cols = m_tables[tableIndex].columns;
  if (columnIndex < 0 || columnIndex >= cols.size())
    return;
  cols[columnIndex].type = static_cast<ColumnType>(type);
  emit dataChanged(this->index(tableIndex), this->index(tableIndex),
                   {ColumnsRole});
}

void SchemaModel::removeColumn(int tableIndex, int columnIndex) {
  if (tableIndex < 0 || tableIndex >= m_tables.size())
    return;
  auto &cols = m_tables[tableIndex].columns;
  if (columnIndex < 0 || columnIndex >= cols.size())
    return;
  cols.removeAt(columnIndex);
  emit dataChanged(this->index(tableIndex), this->index(tableIndex),
                   {ColumnsRole});
}

void SchemaModel::addForeignKey(const QString &fromTable,
                                const QString &fromColumn,
                                const QString &toTable,
                                const QString &toColumn) {
  // find the fromTable index
  for (int i = 0; i < m_tables.size(); i++) {
    if (m_tables[i].name == fromTable) {
      ForeignKey fk;
      fk.fromTable = fromTable;
      fk.fromColumn = fromColumn;
      fk.toTable = toTable;
      fk.toColumn = toColumn;
      m_tables[i].foreignKeys.append(fk);
      emit dataChanged(this->index(i), this->index(i), {ForeignKeysRole});
      return;
    }
  }
}

void SchemaModel::removeForeignKey(int tableIndex, int fkIndex) {
  if (tableIndex < 0 || tableIndex >= m_tables.size())
    return;
  auto &fks = m_tables[tableIndex].foreignKeys;
  if (fkIndex < 0 || fkIndex >= fks.size())
    return;
  fks.removeAt(fkIndex);
  emit dataChanged(this->index(tableIndex), this->index(tableIndex),
                   {ForeignKeysRole});
}

const QList<TableNode> &SchemaModel::tables() const { return m_tables; }

// helpers to convert to QVariantList so QML can read them
QVariantList SchemaModel::columnsToVariant(const QList<Column> &columns) const {
  QVariantList result;
  for (const Column &col : columns) {
    QVariantMap map;
    map["name"] = col.name;
    map["type"] = static_cast<int>(col.type);
    map["primaryKey"] = col.primaryKey;
    map["notNull"] = col.notNull;
    map["unique"] = col.unique;
    map["defaultValue"] = col.defaultValue;
    result.append(map);
  }
  return result;
}

QVariantList
SchemaModel::foreignKeysToVariant(const QList<ForeignKey> &fks) const {
  QVariantList result;
  for (const ForeignKey &fk : fks) {
    QVariantMap map;
    map["fromTable"] = fk.fromTable;
    map["fromColumn"] = fk.fromColumn;
    map["toTable"] = fk.toTable;
    map["toColumn"] = fk.toColumn;
    map["onDelete"] = static_cast<int>(fk.onDelete);
    map["onUpdate"] = static_cast<int>(fk.onUpdate);
    result.append(map);
  }
  return result;
}
