import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    GroupBox {
        title: qsTr("LANGUAGE")
        Layout.fillWidth: true

        RowLayout {
            anchors.fill: parent

            Button {
                id: croatianButton
                text: qsTr("CROATIAN");
                display: AbstractButton.TextUnderIcon;
                Layout.fillWidth: true
                flat: appSettings.language !== "hr_HR"
                enabled: appSettings.language !== "hr_HR"
                icon {
                    width: 192
                    height: 192
                    source: "qrc:///images/flag_cro.png";
                    color: "transparent"
                }
                onClicked: appSettings.setLanguage("hr_HR");
            }

            Button {
                id: englishButton
                text: qsTr("ENGLISH");
                display: AbstractButton.TextUnderIcon;
                Layout.fillWidth: true
                flat: appSettings.language !== "en_US"
                enabled: appSettings.language !== "en_US"
                icon {
                    width: 192
                    height: 192
                    source: "qrc:///images/flag_uk.png";
                    color: "transparent"
                }
                onClicked: appSettings.setLanguage("en_US")
            }
        }
    }

    GroupBox {
        title: qsTr("APPEARANCE");
        Layout.fillWidth: true

        RowLayout {
            anchors.fill: parent

            CheckBox {
                id: darkModeCheckBox
                text: qsTr("DARK_MODE")
                checked: appSettings.isDarkMode
                onCheckedChanged: appSettings.isDarkMode = checked
            }

            RowLayout {
                spacing: 20

                Label {
                    text: qsTr("ROW_COUNT")
                }
                ComboBox {
                    id: rowCountCombo
                    property var selectedElement: model[currentIndex]

                    model: appSettings.sizes
                    currentIndex: appSettings.rowSizeIndex
                    onCurrentIndexChanged: {
                        appSettings.rowSizeIndex = currentIndex
                    }
                }
            }

            RowLayout {
                spacing: 20

                Label {
                    text: qsTr("COLUMN_COUNT")
                }
                ComboBox {
                    id: columnCountCombo
                    property var selectedElement: model[currentIndex]

                    model: appSettings.sizes
                    currentIndex: appSettings.columnSizeIndex
                    onCurrentIndexChanged: {
                        appSettings.columnSizeIndex = currentIndex
                    }
                }
            }
        }
    }

    GroupBox {
        title: qsTr("ACCESIBILITY")
        Layout.fillWidth: true

        RowLayout {
            anchors.fill: parent

            RowLayout {
                spacing: 20

                Label {
                    text: qsTr("WAIT_TIME")
                }
                TextField {
                    text: appSettings.waitTime
                    inputMethodHints: Qt.ImhDigitsOnly
                    validator: IntValidator {
                        bottom: appSettings.minWaitTime;
                        top: appSettings.maxWaitTime;
                    }
                    onTextChanged: appSettings.waitTime = Math.min(Math.max(Number(text), 0), 10000);
                }
            }
        }
    }
}
