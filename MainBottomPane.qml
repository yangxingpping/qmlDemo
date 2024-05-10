import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Shapes 1.5
import FluentUI 1.0


Rectangle{
    id: r
    property var bottomPaneSelectedButtonColor: Qt.rgba(1,1,1,1)
    property var bottomPaneNoSelectButtonColor: Qt.rgba(1,1,1,0.6)
    property string btnClickedBackgroundColor: "#6d829d"
    property var btnDefaultBackgroundColor: Qt.rgba(1,1,1,0.0)
    property int rightBottomWidth: 86
    property int bottomPaneHeight: 64
    property bool debug: true

    anchors{
        right: parent.left
        bottom: parent.bottom
        left: parent.left
        bottomMargin: 0
        rightMargin: 2
        leftMargin: 98
    }
    signal sClickBottomMainMenu(int index, int sub)
    signal sClickBottomDetailMenu(int index)
    height: bottomPaneHeight
    z: 998
    color: "transparent"
    Shape {
        ShapePath {
            id: mainBottomRealPanel
            fillColor: "#5d7492"
            strokeWidth: 2
            strokeColor: "#5d7492"
            startX: 30; startY: 0
            PathSvg { 
                id: mainBottomRealPanelPath
                path: "M38.3513 0C34.6227 0 31.2038 2.0744 29.4817 5.38152L0 %2H765.497H922C923.105 %2 %1 61.1046 %1 60V0H38.3513Z".arg(r.width).arg(r.height)
            }
        }

    }

    Rectangle{
        id: rectBottomMenuMain
        
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width - r.rightBottomWidth
        
        color: "transparent"
        MainBottomMenu{
            id: bottomMenu
            color: "transparent"
        }
    }

    function switchToPage(index){
        bottomMenu.switchToPage(index)
    }

    Rectangle{
        id: rectBottomRight
        color : "transparent"
        anchors.left: rectBottomMenuMain.right
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Rectangle{
            id: rightBottomSep
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            x: 0
            y: 0
            color: Qt.rgba(1,1,1,0.3)
            height: parent.height 
            width: 1

        }
        RoundButton {
                id: btnRightBottom
                radius: 1
                anchors.centerIn: parent
                height: parent.height
                icon.source: r.debug ? "" : "qrc:/example/res/svg/mode_switching_icon.svg"
                icon.color: "transparent"
                icon.width: rectBottomRight.width / 2
                icon.height: rectBottomRight.height / 2
                spacing: 0
                text: "switch"
                display:  r.debug ? AbstractButton.TextOnly : AbstractButton.IconOnly
                Component.onCompleted: {
                    contentItem.color = r.bottomPaneNoSelectButtonColor
                }
                onClicked:{
                    bottomMenu.switchBottomMenu()
                }
                background: Rectangle{
                    color: "transparent"
                }
        }
        
    }
    Connections{
        target: bottomMenu
        function onSClickBottomMainMenu(index, sub){
            sClickBottomMainMenu(index, sub)
        }
        function onSClickBottomDetailMenu(index){
            sClickBottomDetailMenu(index)
        }
    }
}
