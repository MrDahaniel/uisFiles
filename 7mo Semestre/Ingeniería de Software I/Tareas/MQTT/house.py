from unicodedata import name
from room import Room
from device import Device
from remote import Remote


class House:
    def __init__(self, name: str) -> None:
        self.name: str = name
        self.rooms: dict = {}
        self.currId: int = 0
        self.users: list[str] = []
        self.devices: list[str] = []

    def createRoom(self, name: str) -> bool:
        if self.rooms.get("name") is None:
            self.rooms[name] = Room(name, self.currId)
            self.currId += 1
        else:
            return False
        return True

    def createDevice(self, name: str, roomName: str = None) -> bool:
        if roomName in self.rooms.keys() and not name in self.devices:
            newDevice: Device = Device(name)
            self.devices.append(name)
            self.rooms[roomName].addDevice()
        pass

    def createRemote(self) -> None:
        pass

    def createUser(self, name: str) -> None:
        pass

    def loadConfig(self) -> None:
        pass

    def editRoom(
        self,
        roomName: str = None,
        roomId: str = None,
    ) -> bool:
        pass
