import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    GroupBox {
        title: qsTr("LANGUAGE")
        Layout.fillWidth: true

        GridLayout {
            anchors.fill: parent
            columns: 2

            Button {
                id: croatianButton
                text: qsTr("CROATIAN");
                display: AbstractButton.TextUnderIcon;
                Layout.fillWidth: true
                icon {
                    width: 192
                    height: 192
                    source: "qrc:///images/flag_cro.png";
                    color: True
                }
                onClicked: qmlTranslator.selectLanguage("hr_HR"); // FIXME: SAVING
            }

            Button {
                id: englishButton
                text: qsTr("ENGLISH");
                display: AbstractButton.TextUnderIcon;
                Layout.fillWidth: true
                icon {
                    width: 192
                    height: 192
                    source: "qrc:///images/flag_uk.png";
                    color: True
                }
                onClicked: qmlTranslator.selectLanguage("en_US") // FIXME: SAVING
            }
        }
    }

    GroupBox {
        title: qsTr("APPEARANCE");
        Layout.fillWidth: true

        GridLayout {
            anchors.fill: parent
            columns: 2
            CheckBox {
                id: darkModeCheckBox
                text: qsTr("DARK_MODE")
                checked: appSettings.isDarkMode
                onCheckedChanged: appSettings.isDarkMode = checked
            }
        }
    }
}
