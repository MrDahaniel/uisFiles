from person import Person


class Park:
    def __init__(self) -> None:
        self.currentTime: int = 800
        self.attractions: list(Location) = []
        self.activities: list(Location) = []
        self.time: int = 0


class Location:
    def __init__(self, name: str, type: str, serviceRate: int, duration: int) -> None:
        self.name: str = name
        self.type: str = type
        self.serviceRate: int = serviceRate
        self.waitTime: int = 0
        self.fakeWaitTime: int = 0
        self.duration: int = duration
        self.queue: list(Person) = []
