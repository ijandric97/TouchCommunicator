import QtQuick
import QtQuick.Controls.Material

Item {

    Text {
        text: "HELLO WORLD"
        x: 0
        y: 0
    }

    Row {
      anchors.verticalCenter: parent.verticalCenter
      Button { text: "English"; onClicked: qmlTranslator.selectLanguage("en_US") }
      Button { text: "Hrvatski"; onClicked: qmlTranslator.selectLanguage("hr_HR"); }
     }
}
