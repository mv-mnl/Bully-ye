import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0 as SDDM

Rectangle {
    id: container
    width: 640
    height: 480
    color: "black"

    LayoutMirroring.enabled: Qt.locale().textDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.currentIndex
    property string activeFont: config.font || "JetBrainsMono Nerd Font"

    SDDM.TextConstants { id: textConstants }

    // Background removido para usar color black

    // Main Layout
    Item {
        anchors.fill: parent

        // Clock and Date
        Column {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 50
            spacing: 0

            SDDM.Clock {
                id: clock
                color: "black"
                timeFont.family: activeFont
                timeFont.pixelSize: 84
                dateFont.family: activeFont
                dateFont.pixelSize: 24
            }
        }

        // Login Box
        Rectangle {
            id: loginBox
            anchors.centerIn: parent
            width: 420
            height: 400
            radius: 15
            color: Qt.rgba(0, 0, 0, 0.6) // Glass effect
            border.color: Qt.rgba(255, 255, 255, 0.1)
            border.width: 1

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 40
                spacing: 15

                Text {
                    text: "Welcome"
                    color: "white"
                    font.family: activeFont
                    font.pixelSize: 32
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                // Error Message
                Text {
                    id: errorMessage
                    color: "#ff5555"
                    font.family: activeFont
                    font.pixelSize: 14
                    text: " "
                    Layout.alignment: Qt.AlignHCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    Layout.fillWidth: true
                }

                // Username
                ColumnLayout {
                    spacing: 5
                    Layout.fillWidth: true
                    
                    Text {
                        text: "User"
                        color: "#ccc"
                        font.family: activeFont
                        font.pixelSize: 12
                    }

                    TextField {
                        id: name
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        text: userModel.lastUser
                        font.family: activeFont
                        font.pixelSize: 16
                        color: "white"
                        selectByMouse: true
                        background: Rectangle {
                            color: Qt.rgba(255, 255, 255, 0.1)
                            radius: 8
                            border.color: name.activeFocus ? "#3498db" : "transparent"
                        }
                        
                        KeyNavigation.tab: password
                    }
                }

                // Password
                ColumnLayout {
                    spacing: 5
                    Layout.fillWidth: true

                    Text {
                        text: "Password"
                        color: "#ccc"
                        font.family: activeFont
                        font.pixelSize: 12
                    }

                    TextField {
                        id: password
                        Layout.fillWidth: true
                        Layout.preferredHeight: 40
                        echoMode: TextInput.Password
                        font.family: activeFont
                        font.pixelSize: 16
                        color: "white"
                        selectByMouse: true
                        background: Rectangle {
                            color: Qt.rgba(255, 255, 255, 0.1)
                            radius: 8
                            border.color: password.activeFocus ? "#3498db" : "transparent"
                        }

                        KeyNavigation.backtab: name
                        KeyNavigation.tab: loginButton

                        Keys.onPressed: function(event) {
                            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                sddm.login(name.text, password.text, sessionIndex)
                                event.accepted = true
                            }
                        }
                    }
                }

                // Login Button
                Button {
                    id: loginButton
                    text: "Login"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 45
                    
                    background: Rectangle {
                        color: loginButton.down ? "#2980b9" : "#3498db"
                        radius: 8
                    }

                    contentItem: Text {
                        text: loginButton.text
                        font.family: activeFont
                        font.pixelSize: 16
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: sddm.login(name.text, password.text, sessionIndex)
                    
                    KeyNavigation.backtab: password
                    KeyNavigation.tab: session
                }
            }
        }

        // Bottom Bar (Session & Power)
        RowLayout {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 40
            spacing: 20

            // Session Selection
            ComboBox {
                id: session
                Layout.preferredWidth: 220
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                font.family: activeFont
                font.pixelSize: 14
                
                background: Rectangle {
                    color: Qt.rgba(0, 0, 0, 0.6)
                    radius: 8
                    border.color: Qt.rgba(255, 255, 255, 0.2)
                }
                
                contentItem: Text {
                    text: session.displayText
                    font: session.font
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 15
                }
            }

            Item { Layout.fillWidth: true }

            // Power Buttons
            Row {
                spacing: 30

                Text {
                    id: rebootTxt
                    text: "󰜉 Reboot"
                    color: rebootMa.containsMouse ? "#3498db" : "black"
                    font.family: activeFont
                    font.pixelSize: 16
                    
                    MouseArea {
                        id: rebootMa
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: sddm.reboot()
                    }
                }

                Text {
                    id: shutdownTxt
                    text: "󰐥 Shutdown"
                    color: shutdownMa.containsMouse ? "#e74c3c" : "black"
                    font.family: activeFont
                    font.pixelSize: 16

                    MouseArea {
                        id: shutdownMa
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: sddm.powerOff()
                    }
                }
            }
        }
    }

    // Connections
    Connections {
        target: sddm
        function onLoginSucceeded() {
            errorMessage.text = "Login successful!"
            errorMessage.color = "#50fa7b"
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.text = "Login failed"
            errorMessage.color = "#ff5555"
        }
    }

    Component.onCompleted: {
        if (name.text === "")
            name.focus = true
        else
            password.focus = true
    }
}