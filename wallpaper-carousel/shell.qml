import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    PanelWindow {
        id: root
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        visible: true
        
        WallpaperPicker {
            id: picker
            anchors.fill: parent
            visible: true
            focus: true
        }

        Item {
            focus: true
            Keys.onEscapePressed: {
                Quickshell.execDetached(["bash", "-c", "pkill -f quickshell.*shell.qml"])
            }
        }
    }
}
