#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QStandardPaths>

int main(int argc, char *argv[])
{
    // Prepare the application
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // NOTE: Show us where the DB is
    QString storagePath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/QTAsistivna";
    engine.setOfflineStoragePath(storagePath);
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
