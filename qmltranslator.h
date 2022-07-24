#ifndef QMLTRANSLATOR_H
#define QMLTRANSLATOR_H

#include <QObject>
#include <QTranslator>
#include <QDebug>
#include <QGuiApplication>
#include <QDir>
#include <QQmlEngine>


class QmlTranslator : public QObject
{
    Q_OBJECT

public:
    explicit QmlTranslator(QQmlEngine *engine, QObject *parent = nullptr);
    Q_INVOKABLE void selectLanguage(QString language);

private:
    QTranslator *_translator;
    QQmlEngine *_engine;

signals:
    void languageChanged();

};

#endif // QMLTRANSLATOR_H
