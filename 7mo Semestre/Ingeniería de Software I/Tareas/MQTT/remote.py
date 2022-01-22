from paho.mqtt import client, publish


class Remote:
    def __init__(self, name: str, user: str = None) -> None:
        self.name: str = name
        self.user: str = user
        self.channels: list(str) = []

    def listChannels(self) -> list(str):
        return self.channels

    def sendMessage(self, channels: str):
        pass
