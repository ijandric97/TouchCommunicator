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
                text: qsTr("SETTINGS");
                display: AbstractButton.TextUnderIcon
                icon {
                    width: parent.width - 120
                    height: parent.width - 120
                    source: "qrc:///images/btn_settings.png";
                    color: "transparent"
                }
                font {
                    pixelSize: 20
                    bold: true
                }
                onClicked: viewManager.switchToSettings()
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Button {
                anchors.fill: parent
                text: qsTr("COMMUNICATOR");
                display: AbstractButton.TextUnderIcon
                Material.background: Material.Red
                icon {
                    width: parent.width - 120
                    height: parent.width - 120
                    source: "qrc:///images/btn_communicator.png";
                    color: "transparent"
                }
                font {
                    pixelSize: 20
                    bold: true
                }
                onClicked: viewManager.switchToCommunicator()
            }
        }
    }
}
