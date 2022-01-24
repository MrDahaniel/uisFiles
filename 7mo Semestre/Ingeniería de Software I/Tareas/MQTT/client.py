from json import load, dumps
from typing import Union
from paho.mqtt import client
from os.path import isfile


class Client(client.Client):
    def __init__(self, path: str = "config.json"):
        super().__init__()

        if isfile(path):
            data: dict = load(open(path, "r+"))

            # We establish the path
            self.path: str = path

            # We define the chracteristics of the client
            self.name: str = data.get("name")
            self.room: str = data.get("room")
            self.topic: str = f"{self.room}/{self.name}"
            self.broadcast: str = f"{self.room}/Broadcast"
            self.state: dict = data.get("state")

            print(f"Configuration loaded. \n{self.name} is ready.")

        else:
            file = open("config.json", "w")
            json: dict = {
                "host": "",
                "name": "",
                "room": "",
                "id": 0,
                "lastUser": "",
                "state": {},
            }
            file.write(dumps(json))

            print("Missing config file. \nCreating blank file on current directory.")
            return

        self.on_message = self.on_msg

        self.connect(data.get("host"), 1883, 60)

        self.subscribe([(self.topic, 0), (self.broadcast, 0)])
        self.loop_forever()

    def updateState(self, stateName: str, newValue: Union[str, int, bool]):
        if stateName in self.state.keys():
            self.state[stateName] = newValue
            print(f"{self.name} updated.\n{stateName} updated to {newValue}.")
        else:
            print(f"{self.name} has no {stateName}. \nUpdate failed.")

    def on_msg(self, client, userData, msg: client.MQTTMessage):
        payld: dict = eval(str(msg.payload)[2:-1])

        # Handle the remote messages
        if self.topic == str(msg.topic):
            if "update" in (payld.keys()):
                updt: dict = payld.get("update")

                for keyName in updt.keys():
                    self.state[keyName] = updt.get(keyName)
                    print("\nUpdate operation complete.\nState changed.")
                print(f"\nCurrent State: \n{self.state}")

            else:
                print("No valid operation found. Transaction failed.")

        # Handle broadcast messages
        elif self.broadcast[:-1] == msg.topic[:-1]:
            print(f"Broadcast message: {str(msg.payload)[2:-1]}")


Client()
