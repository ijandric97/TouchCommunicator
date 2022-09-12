#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QIcon>

#include "qmltranslator.h"
#include "fileio.h"


int main(int argc, char *argv[])
{
    // Prepare the application
    //qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QmlTranslator qmlTranslator(&engine);
    FileIO fileIO;

    // Register and expose C++ methods to QML
    // NOTE: Has to be done before engine has loaded!!!
    engine.rootContext()->setContextProperty("qmlTranslator", &qmlTranslator);
    engine.rootContext()->setContextProperty("fileIO", &fileIO);

    // NOTE: Show us where the DB is
    qDebug() << engine.offlineStoragePath();

    // Set the icon file
    app.setWindowIcon(QIcon(":/images/icon.ico"));

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
