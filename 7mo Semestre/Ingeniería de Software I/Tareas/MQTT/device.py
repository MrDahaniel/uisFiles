from paho.mqtt import client, publish


class Device:
    def __init__(self, name: str) -> None:
        self.name: str = name
        self.state: dict = {
            "channels": [],
        }

    def updateState(self):
        pass
