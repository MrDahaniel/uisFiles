from __future__ import annotations


class Command:
    def __init__(self) -> None:
        pass

    def execute(self):
        pass


class IncreaseVolume(Command):
    def __init__(self, television: Television) -> None:
        super().__init__()
        self.television: Television = television

    def execute(self):
        self.television.increaseVolume()


class DecreaseVolume(Command):
    def __init__(self, television: Television) -> None:
        super().__init__()
        self.television: Television = television

    def execute(self):
        self.television.DecreaseVolume()


class Television:
    def __init__(self) -> None:
        self.volume: int = 0

    def increaseVolume(self):
        if self.volume <= 10:
            self.volume += 1
            print(f"El volumen ahora es {self.volume}")
        else:
            print("El volumen ya está en 10")

    def decreaseVolume(self):
        if self.volume >= 0:
            self.volume -= 1
            print(f"El volumen ahora es {self.volume}")
        else:
            print("El volumen ya está en 0")


class Remote:
    def __init__(self, television: Television) -> None:
        self.television: Television = television

    def pressButton(self, command: Command):
        command.execute()


# Main

bichovision: Television = Television()
controlRemoto: Remote = Remote(television=bichovision)

controlRemoto.pressButton(IncreaseVolume())

print(bichovision.volume)

controlRemoto.pressButton(DecreaseVolume())

print(bichovision.volume)
