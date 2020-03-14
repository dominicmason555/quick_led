import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from Bridge import Bridge


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    bridge = Bridge()

    context = engine.rootContext()
    context.setContextProperty("con", bridge)

    engine.load(os.path.abspath("view.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec_())
