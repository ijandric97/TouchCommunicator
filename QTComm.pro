QT += quick

CONFIG += c++11

SOURCES += \
        fileio.cpp \
        main.cpp \
        qmltranslator.cpp

HEADERS += \
    fileio.h \
    qmltranslator.h

RESOURCES += qml.qrc

TRANSLATIONS += \
    translations\QTComm_hr_HR.ts \
    translations\QTComm_en_US.ts

CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
# QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
# QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
