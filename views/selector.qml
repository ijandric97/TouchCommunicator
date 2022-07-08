import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    GridLayout {
        anchors.fill: parent
        columns: 2
        rows: 1

        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 32
            Layout.rightMargin: 16
            text: "Settings"

            onClicked: appSettings.switchToSettings()
        }

        Button {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 32
            Layout.leftMargin: 16
            text: "Communicator"
            Material.background: Material.Red
            onClicked: appSettings.switchToCommunicator();
        }
    }
}
