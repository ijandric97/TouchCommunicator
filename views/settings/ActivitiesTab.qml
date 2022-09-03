import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    id: activitiesTab
    property int isForm: 0

    StackLayout {
        anchors.fill: parent
        currentIndex: isForm ? 1 : 0

        Communicator { }
        AddEditForm { }
    }
}
