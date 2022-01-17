from person import Person


class Park:
    def __init__(self) -> None:
        self.currentTime: int = 800
        self.attractions: dict = {}
        self.activities: list()


class Location:
    def __init__(self, name: str, serviceRate: int, duration: int) -> None:
        self.name: str = name
        self.serviceRate: int = serviceRate
        self.waitTime: int = 0
        self.fakeWaitTime: int = 0
        self.duration: int = 0
        self.queue: list(Person) = []


class Hub(Location):
    def __init__(self) -> None:
        super().__init__()
