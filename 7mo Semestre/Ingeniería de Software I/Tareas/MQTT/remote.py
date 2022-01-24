from os.path import isfile
from json import load, dumps
from paho.mqtt import client


class Remote(client.Client):
    def __init__(self, path: str = "remote.json") -> None:
        super().__init__()
        if isfile(path):
            data: dict = load(open(path, "r+"))

            # We set the path to self
            self.path: str = path

            # We define the remote
            self.user: str = data.get("user")
            self.rooms: dict[str, dict[str, dict[str, dict[str, int]]]] = data.get(
                "rooms"
            )
            self.currentTopic: str = None

            self.connect(data.get("host"), 1883, 60)
            print(f"Configuration loaded. \n{self.user}'s remote is ready.\n\n")
        else:
            file = open("remote.json", "w")
            json: dict = {
                "user": "dnl",
                "host": "test.mosquitto.org",
                "rooms": {
                    "[roomName]": {
                        "Devices": {
                            "[DeviceName]": {"state": {"[StateName]": "[Value]"}}
                        }
                    }
                },
            }
            file.write(dumps(json))

            print("Missing config file. \nCreating blank file on current directory.")
            return

        self.Menu()

    def Menu(self):
        print("Select a topic:")
        self.currentTopic = self.selectTopic()
        while True:

            print("\nMain Menu:\n    0. Change topic")
            print(f"    1. Update {self.currentTopic} state")
            print("    2. Disconnect")

            try:
                sel = int(input("Enter your selection: "))
                if sel == 0:
                    self.currentTopic = self.selectTopic()
                elif sel == 1:
                    self.sendUpdateMessage()
                elif sel == 2:
                    break

            except:
                print("Invalid selection.")

        print("Goodbye...")

    def selectTopic(self) -> str:
        print("Select room:")
        for idx, room in enumerate(self.rooms.keys()):
            print(f"    {idx}. {room}")

        while True:
            try:
                sel = int(input("Enter your selection: "))
                if sel in range(0, len(self.rooms.keys())):
                    break
            except:
                print("Invalid selection.")
                pass

        topicRoom: str = list(self.rooms.keys())[sel]

        print("\nSelect device")
        for idx, device in enumerate(self.rooms[topicRoom]["Devices"].keys()):
            print(f"   {idx}. {device}")

        while True:
            try:
                sel = int(input("Enter your selection: "))
                if sel in range(0, len(self.rooms[topicRoom]["Devices"].keys())):
                    break
            except:
                pass

        self.publish(
            f"{topicRoom}/{list(self.rooms[topicRoom]['Devices'].keys())[sel]}",
            payload=dumps({"update": {"lastUser": self.user}}),
        )

        return f"{topicRoom}/{list(self.rooms[topicRoom]['Devices'].keys())[sel]}"

    def sendUpdateMessage(self):
        room, device = self.currentTopic.split("/")
        deviceState: list[str] = list(self.rooms[room]["Devices"][device].keys())

        for idx, state in enumerate(deviceState):
            print(f"    {idx}. {state}")

        stateIndex: int = int(input("Enter your selection: "))

        if stateIndex in range(0, len(deviceState)):
            try:
                newValue = int(input(f"New value for {deviceState[stateIndex]}: "))
                self.publish(
                    self.currentTopic,
                    payload=dumps(
                        {
                            "update": {
                                list(self.rooms[room]["Devices"][device].keys())[
                                    stateIndex
                                ]: newValue,
                                "lastUser": f"{self.user}",
                            }
                        }
                    ),
                )

            except:
                print("Invalid value. No message sent.")

        else:
            print(f"No state with index {stateIndex}. No message sent.")


Remote()
