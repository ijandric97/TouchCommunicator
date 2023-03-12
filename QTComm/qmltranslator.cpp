#include "qmltranslator.h"

QmlTranslator::QmlTranslator(QQmlEngine *engine, QObject *parent) : QObject{parent}
{
    _translator = new QTranslator(this);
    _engine = engine;
}

void QmlTranslator::selectLanguage(QString language)
{
    const QString baseName = "QTComm_" + language;

    if (!_translator->load(":/i18n/" + baseName))
    {
        qDebug() << "Failed to load translation file, loading english";
        if (!_translator->load(":/i18n/QTComm_en_US")) {
            qDebug() << "Failed to load translation file, loading english";
        } {
            qDebug() << "Failed to load default english translation, removing translator";
            qApp->removeTranslator(_translator);
            return;
        }
    }

    // It is a global thing, we can use it anywhere (after #including <QGuiApplication>)
    qApp->installTranslator(_translator);
    _engine->retranslate();

    emit languageChanged();
}
