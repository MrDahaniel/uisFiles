from numpy import random
from device import Device


class Room:
    def __init__(self, name: str, id: str) -> None:
        self.name: str = name
        self.id: str = id
        self.devices: dict(str, Device) = {}

    def addDevice(self):
        pass
