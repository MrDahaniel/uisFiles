import imp
from room import Room
from device import Device
from remote import Remote


class House:
    def __init__(self, name: str) -> None:
        self.name: str = name
        self.rooms: dict(str, Room) = {}
        self.users: list(str) = []
        self.devices: list(Device) = []

    def createRoom(self) -> None:

        pass

    def createDevice(self) -> None:
        pass

    def createRemote(self) -> None:
        pass

    def createUser(self, name: str) -> None:
        pass

    def loadConfig(self) -> None:
        pass

    def editRoom(self, roomName: str = None, roomId: str = None):
        pass
