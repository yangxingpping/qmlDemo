import QtQuick
import QtQuick.Controls
import Qt.labs.qmlmodels
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl


Rectangle{
    id: r
    property var bottomPaneSelectedButtonColor: Qt.rgba(1,1,1,1)
    property var bottomPaneNoSelectButtonColor: Qt.rgba(1,1,1,0.6)
    property string btnClickedBackgroundColor: "#6d829d"
    property var btnDefaultBackgroundColor: Qt.rgba(1,1,1,0.0)
    property int cncModeIndex: 0
    property int tryCncModeIndex: 0
    property bool debug: true
    anchors.fill: parent
    color: "transparent"
    signal sClickBottomMainMenu(int index, int sub);
    signal sClickBottomDetailMenu(int index);

    Timer{
        running: r.debug
        interval: 2000
        onTriggered: {

        }
    }

    function updateMainPage(index){
        updateGroupDisplay(groupMainButtons, index);
    }

    function updateDetailPage(index){
        updateGroupDisplay(groupDetailButtons, index);
    }

    function updateGroupDisplay(btnGroup, index){
        if(btnGroup.clickedIndex != -1){
            setUnchecked(btnGroup.buttons[btnGroup.clickedIndex]);
        }

        btnGroup.clickedIndex = index;
        btnGroup.checkedButton = btnGroup.buttons[index];
        setChecked(btnGroup.buttons[index]);
    }

    function setChecked(btn){
        if(btn && btn.contentItem){
            btn.contentItem.color = r.bottomPaneSelectedButtonColor
        } 
        if(btn && btn.background){
            btn.background.color = r.btnClickedBackgroundColor
        }
    }
    function setUnchecked(btn){
        btn.contentItem.color =  r.bottomPaneNoSelectButtonColor
        btn.background.color = "transparent";
    }
    Rectangle{
        id: rectBottomMenuMain
        x: 0
        y: 0
        color: "transparent"
        width: parent.width
        height: parent.height
        ButtonGroup{
            id: groupMainButtons
            exclusive: true
            property int clickedIndex: -1
            onClicked: function(btn) {
            }
        }
        ListModel {
            id: mainModel
            ListElement {
                name: qsTr("Prod")
                iconsource: "Prod.svg"
            }
            ListElement {
                name: qsTr("Prog")
                iconsource: "Prog.svg"
            }
            ListElement {
                name: qsTr("Tool")
                iconsource: "Tool.svg"
            }
            ListElement {
                name: qsTr("Work")
                iconsource: "Work.svg"
            }
            ListElement {
                name: qsTr("Variable")
                iconsource: "Variable.svg"
            }
            ListElement {
                name: qsTr("Diag")
                iconsource: "Diag.svg"
            }
            ListElement {
                name: qsTr("Service")
                iconsource: "Service.svg"
            }
            ListElement {
                name: qsTr("Extend")
                iconsource: "Extend.svg"
            }
        }
        ListView {
            id: rowBottomBtns
            topMargin: 0
            bottomMargin: 0
            leftMargin: 68
            interactive: false
            rightMargin: r.width > 700 ? 68 : 10
            anchors.fill: parent
            orientation: ListView.Horizontal
            model: mainModel
            delegate: RoundButton {
                id: control
                height: parent.height
                ButtonGroup.group: groupMainButtons
                width : (rowBottomBtns.width - rowBottomBtns.leftMargin - rowBottomBtns.rightMargin) / mainModel.count
                radius: 2
                text: name
                font.pixelSize: 10
                icon.source: r.debug ? "" : "qrc:/example/res/svg/" + iconsource
                icon.color: "transparent"
                icon.width: 48
                icon.height: 40
                spacing: 0
                display: AbstractButton.TextUnderIcon
                onClicked: {
                    sClickBottomMainMenu(index + 1, 0);
                    if(r.debug){
                        r.updateMainPage(index);
                    }
                }

                background:  Rectangle {
                    implicitHeight: control.Material.delegateHeight

                    color:  "transparent"

                    Ripple {
                        clip: true
                        clipRadius: parent.radius
                        width: parent.width
                        height: parent.height
                        pressed: control.pressed
                        anchor: control
                        active: enabled && (control.down || control.visualFocus || control.hovered)
                        color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
                    }
                }
                Component.onCompleted: {
                    contentItem.color =  r.bottomPaneNoSelectButtonColor
                }
            }
            Component.onCompleted: {
                r.updateMainPage(0);
            }
        }
    }
    Rectangle{
        id: rectBottomMenuDetail
        color: "transparent"
        x: parent.x
        y: parent.y + rectBottomMenuMain.height
        width: parent.width
        height: 0
        ButtonGroup{
            id: groupDetailButtons
            exclusive: true
            onClicked: function(btn) {
                if(checkedButton){
                    checkedButton.contentItem.color =  r.bottomPaneNoSelectButtonColor
                    checkedButton.background.color = "transparent"
                }

                btn.contentItem.color = r.bottomPaneSelectedButtonColor 
                btn.background.color = r.btnClickedBackgroundColor
                //checkedButton = btn
                if(!r.debug){
                    pagemain.switchPageFromQML(btn.index, 0)
                }
            }
            Component.onCompleted: {
            }
        }
        ListModel {
            id: detailModel
            ListElement {
                name: qsTr("ProdY")
                iconsource: "Prod.svg"
            }
            ListElement {
                name: qsTr("ProgX")
                iconsource: "Prog.svg"
            }
        }
        ListView {
            id: rowBottomDetails
            topMargin: 0
            bottomMargin: 0
            interactive: false
            leftMargin: 68/2
            rightMargin: 10 //r.width > 700 ? 68 : 10
            orientation: ListView.Horizontal
            anchors.fill: parent
            model: detailModel
            delegate: RoundButton {
                id: control2
                height: rowBottomDetails.height
                ButtonGroup.group: groupDetailButtons
                width : (rowBottomDetails.width - rowBottomDetails.leftMargin - rowBottomDetails.rightMargin) / detailModel.count
                radius: 2
                text: name
                font.pixelSize: r.width > 700 ? 10 : 8 //10
                icon.source: r.debug ? "" : "qrc:/example/res/svg/" + iconsource
                icon.color: "transparent"
                icon.width: 30
                icon.height: 30
                spacing: 0
                display: AbstractButton.TextUnderIcon
                background: Rectangle{
                    color: "transparent"
                    Ripple {
                        clip: true
                        clipRadius: parent.radius
                        width: parent.width
                        height: parent.height
                        pressed: control2.pressed
                        anchor: control2
                        active: enabled && (control2.down || control2.visualFocus || control2.hovered)
                        color: control2.flat && control2.highlighted ? control2.Material.highlightedRippleColor : control2.Material.rippleColor
                    }
                }
                onClicked: {
                    sClickBottomDetailMenu(index)
                }
                Component.onCompleted: {
                    contentItem.color =  r.bottomPaneNoSelectButtonColor
                }
            }
            
            Component.onCompleted: {
                groupBtnDetails.checkedButton = groupBtnDetails.buttons[r.cncModeIndex]
                groupBtnDetails.buttons[r.cncModeIndex].contentItem.color = r.bottomPaneSelectedButtonColor
                groupBtnDetails.buttons[r.cncModeIndex].background.color = r.btnClickedBackgroundColor
            }
        }
    }

    AnimationController {
        id: controllerBottom
        property bool toEnd: true
        animation: ParallelAnimation {
            id: animBottomMenu
            property int timemini : 600
            NumberAnimation { target: rectBottomMenuMain; property: "y"; duration: animBottomMenu.timemini; from: 0; to: -r.height; easing.type: Easing.InOutQuad }
            NumberAnimation { target: rectBottomMenuMain; property: "height"; duration: animBottomMenu.timemini; from: r.height; to: 0; easing.type: Easing.InOutQuad }
            //NumberAnimation { target: rectBottomMenuMain; property: "width"; duration: animBottomMenu.timemini; from: r.width; to: 0; easing.type: Easing.InOutQuad }
            NumberAnimation { target: rectBottomMenuDetail; property: "y"; duration: animBottomMenu.timemini; from: r.height; to: 0; easing.type: Easing.InOutQuad }
            NumberAnimation { target: rectBottomMenuDetail; property: "height"; duration: animBottomMenu.timemini; from: 0; to: r.height; easing.type: Easing.InOutQuad }
            onFinished: {

            }
            onStarted: {
            }
        }
    }

    function switchBottomMenu(){
        if(controllerBottom.toEnd){
            controllerBottom.completeToEnd();
        }
        else{
            controllerBottom.completeToBeginning()
        }
        controllerBottom.toEnd = !controllerBottom.toEnd
    }

    Component.onCompleted: {
    }

    function initProdDetailMenu(){
        detailModel.clear()
        detailModel.append({"name": qsTr("Auto"),"iconsource": "ProdAuto.svg"});
        detailModel.append({"name": qsTr("Single"),"iconsource": "ProdSingle.svg"});
        detailModel.append({"name": qsTr("MDI"),"iconsource": "ProdMDI.svg"});
        detailModel.append({"name": qsTr("Rapid"),"iconsource": "ProdRapid.svg"});
        detailModel.append({"name": qsTr("Search"),"iconsource": "ProdSearch.svg"});
        detailModel.append({"name": qsTr("Test"),"iconsource": "ProdTest.svg"});
        detailModel.append({"name": qsTr("Manual"),"iconsource": "ProdManual.svg"});
        detailModel.append({"name": qsTr("Home"),"iconsource": "ProdHome.svg"});
        detailModel.append({"name": qsTr("Jog"),"iconsource": "ProdJog.svg"});
        detailModel.append({"name": qsTr("NCFunc"),"iconsource": "ProdNCFunc.svg"});
    }

    function switchToPage(index){
        switch(index){
            case 0: //home(load) page
            {
                r.visible = false
            }break;
            case 1: //prod page
            {
                initProdDetailMenu()
                r.visible = true
            }break;
            case 2: //prog page
            {
                r.visible = true
            }
            default:
            {

            }break;
        }
        if(btnsBotton.checkedButton){
            r.setUnchecked(btnsBotton.checkedButton)
        }
        r.setChecked(btnsBotton.buttons[index-1])
    }
}
