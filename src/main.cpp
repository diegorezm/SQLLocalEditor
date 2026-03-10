#include "src/models/schemamodel.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);

  SchemaModel schemaModel;
  engine.rootContext()->setContextProperty("schemaModel", &schemaModel);
  engine.loadFromModule("SQLLocalEditor", "Main");

  return app.exec();
}
