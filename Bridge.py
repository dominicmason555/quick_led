import requests
import logging
from PySide2.QtCore import QObject, Slot

logging.basicConfig(level=logging.INFO)

class Bridge(QObject):
    @Slot(int, str, result=int)
    def setLEDState(self, action, colour):
        logging.info("Setting static state")
        try:
            r = requests.get("http://192.168.0.65/setLEDState",
                             params={"action": action, "colour": colour},
                             timeout=0.5)
            logging.info(f"Requesting {r.url}")
            logging.info(f"Got code {r.status_code}")
            return r.status_code
        except requests.exceptions.Timeout:
            logging.warning("Request timed out")
            return -1

