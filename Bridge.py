import requests
import logging
from PySide2.QtCore import QObject, Slot

logging.basicConfig(level=logging.INFO)

class Bridge(QObject):
    @Slot(str, result=bool)
    def setLEDStatic(self, colour):
        logging.info("Setting static state")
        r = requests.get("http://192.168.0.65/setLEDState", params={"action": 1, "colour": colour})
        logging.info(f"Requesting {r.url}")
        logging.info(f"Got code {r.status_code}")
        return r.status_code == requests.codes.ok
