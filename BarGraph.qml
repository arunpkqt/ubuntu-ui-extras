/***************************************************************************
 * Whatsoever ye do in word or deed, do all in the name of the             *
 * Lord Jesus, giving thanks to God and the Father by him.                 *
 * - Colossians 3:17                                                       *
 *                                                                         *
 * Ubuntu UI Extras - A collection of QML widgets not available            *
 *                    in the default Ubuntu UI Toolkit                     *
 * Copyright (C) 2013 Michael Spencer <spencers1993@gmail.com>             *
 *                                                                         *
 * This program is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
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
import Ubuntu.Components.ListItems 0.1

Item {
    id: root

    property var colors: []
    property var values: [[]]
    property var names: []
    property var labels: []

    property bool autoSize: false // true to show more values the wider the graph
    property int count: autoSize ? Math.round((graph.width + repeater.spacing)/(barWidth + repeater.spacing), 0) - 1 : values.length
    property int maxValue
    property int barWidth: autoSize ? units.gu(3) : units.gu(3) // TODO: Auto calculate?

    property real scale: (graph.height - 2)/maxValue

    Row {
        id: legendBar

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            margins: units.gu(2)
        }

        spacing: units.gu(3)

        Repeater {
            model: names.length
            delegate: Row {
                spacing: units.gu(1)
                UbuntuShape {
                    anchors.verticalCenter: parent.verticalCenter
                    width: units.gu(3)
                    height: width
                    color: colors[index]
                }
                Label {
                    anchors.verticalCenter: parent.verticalCenter
                    text: names[index]
                    //color: Theme.palette.normal.overlayText
                }
            }
        }
    }

    UbuntuShape {
        id: graph
        color: "white"
        radius: "medium"

        anchors {
            top: legendBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: units.gu(2)
            bottomMargin: units.gu(9)
        }

        Repeater {
            model: root.maxValue + 1

            delegate: Rectangle {
                color: index === root.maxValue || index === 0 ? "transparent" : "lightgray"
                height: 1
                y: root.scale * index + 1
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 1
                }

//                Label {
//                    text: {
//                        if (index === 0)
//                            return "100%"
//                        else if (index === graph.count - 1)
//                            return "0%"
//                        else
//                            return ""
//                    }
//                    color: Theme.palette.normal.overlayText
//                    anchors {
//                        left: parent.left
//                        leftMargin: units.gu(1)
//                        bottom: parent.bottom
//                        bottomMargin: units.gu(1)
//                    }
//                }
            }
        }

        Row {
            id: repeater

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            spacing: units.gu(1)

            Repeater {
                model: root.values
                delegate: BarGraphBar {
                    graph: root
                    width: barWidth
                    height: graph.height
                    values: root.values[index]
                    label: labels[index] || ""
                }
            }
        }
    }
}