#ifndef COLUMN_H
#define COLUMN_H

#include <QString>

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
  ColumnType type = ColumnType::Text;
  bool primaryKey = false;
  bool notNull = false;
  bool unique = false;
  QString defaultValue;
};

#endif
