import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1
import QtGraphicalEffects 1.0
//import 'slides/social'
/*
import Qt3D 2.0
import Qt3D.Shapes 2.0
*/
ApplicationWindow {
	id: app;
	visible: true;
	color: '#bb000000';
	width: 1024;
	height: 768;
//	visibility: Window.FullScreen;
	title: 'Hankathon';

	Item {
		focus: true;
		Keys.onPressed: {
			switch(event.key) {
			case Qt.Key_Left:
				timerPanel.state = 'focus';
				break;

			case Qt.Key_Right:
				timerPanel.state = 'minimize';
				break;
			}
		}
	}

	FontLoader {
		id: numberFont;
		source: 'fonts/aldrich.regular.ttf';
	}

	Rectangle {
		id: messageBox;
		width: parent.width * 0.7;
		height: parent.height * 0.7;
		anchors.centerIn: parent;
		color: '#1111ffff';
		radius: parent.width * 0.01;

		layer.enabled: true;
		layer.smooth: true;
		layer.effect: FastBlur {
			cached: true;
			source: messageBox;
			transparentBorder: true;
			radius: 64
		}
	}
/*
	Text {
		anchors.centerIn: parent;
		font.pointSize: 36;
		font.family: numberFont.name;
		font.bold: true;
		color: '#ffffff';
		text: 'Hackathon Taiwan\n這次將於 3/7、3/8 舉行！\n\n這是現場的倒數計時器程式測試！\nXDDDD';
	}
*/

	Logo {
		anchors.centerIn: parent;
		width: parent.width * 0.15;
		height: parent.height * 0.15;

		onFinished: {
		}

		Timer {
			interval: 1000;
			running: (parent.state == 'normal');
			repeat: false;
			onTriggered: {
				clock.visible = true;
			}
		}
	}

	Clock {
		id: clock;
		anchors.centerIn: parent;
		anchors.margins: parent.width * 0.05;
		height: parent.height * 0.5;
		width: height;
		visible: false;
		onFinished: {
			clock.width *= 0.4;
			clock.height *= 0.4;
			clock.anchors.centerIn = undefined;
			clock.state = 'normal';
		}
	}

	TimerPanel {
		property int baseSize: parent.height * 0.5;
		id: timerPanel;
		anchors.centerIn: parent;
		height: baseSize;
		width: height;
		visible: (clock.state == 'normal');
		onFinished: {
			if (timerPanel.state)
				return;
/*
			timerPanel.width *= 0.4;
			timerPanel.height *= 0.4;
*/
			timerPanel.anchors.centerIn = undefined;
			timerPanel.state = 'minimize';
			console.log('11');
		}
		onTimeout: {
			timerPanel.width = parent.height * 0.5;
			timerPanel.height = timerPanel.width;
			timerPanel.anchors.centerIn = parent;
			messageBox.color = '#11ff1111';
			timerPanel.state = 'timesup';
			console.log('TIMESUP');
		}

		states: [
			State {
				name: 'minimize';
				extend: 'normal';

				PropertyChanges {
					target: timerPanel;
					width: timerPanel.baseSize * 0.4;
					height: timerPanel.baseSize * 0.4;
				}
			},
			State {
				name: 'focus';

				PropertyChanges {
					target: timerPanel;
					width: timerPanel.baseSize;
					height: timerPanel.baseSize;
				}

				AnchorChanges {
					target: timerPanel;
					anchors.top: undefined;
					anchors.left: undefined;
					anchors.horizontalCenter: timerPanel.parent.horizontalCenter;
					anchors.verticalCenter: timerPanel.parent.verticalCenter;
				}
			}
		]
	}
/*
	Social {
		anchors.fill: parent;		
	}
*/
	SponsorSlider {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 100;

		list: ListModel {
			ListElement {
				imagePath: './logo/HanGee.jpg';
			}
			ListElement {
				imagePath: './logo/AvengerGear.jpg';
			}
			ListElement {
				imagePath: './logo/CustardCream.jpg';
			}
			ListElement {
				imagePath: './logo/TaiwanLD.jpg';
			}
			ListElement {
				imagePath: './logo/DOITT.png';
			}
		}
	}
/*
	SponsorSlider {
		anchors.left: parent.left;
		anchors.right: parent.right;
		anchors.bottom: parent.bottom;
		height: 100;

		list: ListModel {
			ListElement {
				imagePath: './logo/netgear.png';
			}
			ListElement {
				imagePath: './logo/vivotek.jpg'
			}
			ListElement {
				imagePath: './logo/pearnature.png'
			}
			ListElement {
				imagePath: './logo/qt.png';
			}
		}
	}
*/
}
