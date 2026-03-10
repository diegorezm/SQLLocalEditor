#ifndef FOREIGNKEY_H
#define FOREIGNKEY_H

#include <QString>

struct ForeignKey {
  QString fromTable;
  QString fromColumn;
  QString toTable;
  QString toColumn;

  enum class Action { NoAction, Cascade, SetNull, Restrict };

  Action onDelete = Action::NoAction;
  Action onUpdate = Action::NoAction;
};

#endif
