import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    RowLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 32

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                anchors.fill: parent
                text: "Settings"
                onClicked: viewManager.switchToSettings()
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                anchors.fill: parent
                text: "Communicator"
                Material.background: Material.Red
                onClicked: viewManager.switchToCommunicator()
            }
        }
    }
}
