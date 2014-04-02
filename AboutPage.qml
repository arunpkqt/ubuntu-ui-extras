/***************************************************************************
 * Whatsoever ye do in word or deed, do all in the name of the             *
 * Lord Jesus, giving thanks to God and the Father by him.                 *
 * - Colossians 3:17                                                       *
 *                                                                         *
 * Ubuntu UI Extras - A collection of QML widgets not available            *
 *                    in the default Ubuntu UI Toolkit                     *
 * Copyright (C) 2013 Michael Spencer <sonrisesoftware@gmail.com>          *
 *                                                                         *
 * This program is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 2 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * This program is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the            *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with this program. If not, see <http://www.gnu.org/licenses/>.    *
 ***************************************************************************/
import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "listutils.js" as List

TabbedPage {
    id: page
    
    title: i18n.tr("About")

    tabs: [i18n.tr("About"), i18n.tr("Credits")]

    property string appName
    property var credits
    property string website
    property string reportABug
    property string version
    property string copyright
    property string author
    property string contactEmail
    property bool iconFrame: true

    property color linkColor: "blue"

    property alias icon: icon.source

    function colorLinks(text) {
        return text.replace(/<a(.*?)>(.*?)</g, "<a $1><font color=\"" + linkColor + "\">$2</font><")
    }

    Item {
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: show ? 0 : -width

            Behavior on leftMargin {
                UbuntuNumberAnimation {}
            }
        }

        width: parent.width

        opacity: show ? 1 : 0

        Behavior on opacity {
            UbuntuNumberAnimation {}
        }

        property bool show: selectedTab === i18n.tr("About")

        Column {
            anchors {
                centerIn: parent
                margins: units.gu(3)
                topMargin: units.gu(8)
            }

            spacing: units.gu(3)

            UbuntuShape {
                visible: iconFrame
                image: Image {
                    id: icon
                }

                width: units.gu(16)
                height: width * icon.sourceSize.height/icon.sourceSize.width
                radius: "medium"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                source: icon.source
                width: units.gu(16.1)
                height: width * icon.sourceSize.height/icon.sourceSize.width

                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                fontSize: "large"
                text: appName
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: author
                }

                Label {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: contactEmail
                }
            }

            Label {
                text: colorLinks(i18n.tr("<a href=\"%1\">Report a Bug</a> • <a href=\"%2\">Website</a>").arg(reportABug).arg(website))
                anchors.horizontalCenter: parent.horizontalCenter
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Label {
                text: i18n.tr("Version <b>%1</b>").arg(version)
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Label {
                text: i18n.tr(copyright)
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Item {
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            rightMargin: show ? 0 : -width

            Behavior on rightMargin {
                UbuntuNumberAnimation {}
            }
        }

        width: parent.width

        opacity: show ? 1 : 0

        Behavior on opacity {
            UbuntuNumberAnimation {}
        }

        property bool show: selectedTab === i18n.tr("Credits")

        ListView {
            anchors.fill: parent
            model: List.objectKeys(credits)
            delegate: ListItem.SingleValue {
                text: modelData
                value: credits[modelData]
            }
        }
    }
}