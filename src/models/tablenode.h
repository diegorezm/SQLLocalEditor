#ifdef TABLENODE_H
#define TABLENODE_H

enum class ColumnType {
  Integer,
  Float,
  Text,
  Boolean,
  Date,
  DateTime,
  Blob,
};

struct Column {
  QString name;
  ColumnType type;
  bool primaryKey = false;
  bool notNull = false;
  bool unique = false;
  QString defaultValue;
};

struct ForeignKey {
  // the "owning" side — e.g. orders.user_id
  QString fromTable;
  QString fromColumn;

  // the "referenced" side — e.g. users.id
  QString toTable;
  QString toColumn;

  // what happens when the referenced row is deleted
  enum class Action { NoAction, Cascade, SetNull, Restrict };
  Action onDelete = Action::NoAction;
  Action onUpdate = Action::NoAction;
};

struct TableNode {
  QString name;
  QList<Column> columns;
  QList<ForeignKey> foreignKeys; // FKs that belong to this table

  // canvas position
  float x = 0;
  float y = 0;
};

#endif // TABLENODE_H
