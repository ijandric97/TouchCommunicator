#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "qmltranslator.h"


int main(int argc, char *argv[])
{
    // Prepare the application
    //qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QmlTranslator qmlTranslator(&engine);

    // Register and expose C++ methods to QML
    engine.rootContext()->setContextProperty("qmlTranslator", &qmlTranslator);

    // Load the main.qml file
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
