import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtMultimedia

import "../libraries/Base64.js" as Base64;
import "../libraries/Utils.js" as Utils;

Item {
    anchors.fill: parent

    property int count: 0

    SoundEffect {
        id: audioOutput
        source: ""
    }

    MouseArea {
        width: 25
        height: 35
        onPressed: exitTimer.start();
        onReleased: exitTimer.stop();
        Timer {
            id: exitTimer
            interval: 1000
            running: false
            repeat: false
            onTriggered: Qt.quit();
        }
    }

    Button {
        anchors.fill: parent
        anchors.margins: 32
        display: AbstractButton.IconOnly
        icon {
            width: parent.height
            height: parent.height
            source: count > 0 ? "qrc:///images/" + count + ".png" : "qrc:///images/button.png"
            color: "transparent"
        }
        font {
            pixelSize: 20
            bold: true
        }
        onPressed: {
            // We have pressed the button start the timer
            resetCountTimer.stop();
            actionButtonTimer.start();
        }
        onReleased: {
            // We have released the button before the timer has finished, reset the timer
            resetCountTimer.start();
            actionButtonTimer.stop();
        }
        Timer {
            id:  actionButtonTimer
            interval: appSettings.waitTime
            running: false
            repeat: false
            onTriggered: {
                count = count < 20 ? count + 1 : 1;
                audioOutput.source = "qrc:///sounds/" + count + ".wav";
                audioOutput.play();
            }
        }
    }

    Timer {
        id: resetCountTimer
        interval: 10000
        running: false
        repeat: false
        onTriggered: {
            count = 0
        }
    }
}
