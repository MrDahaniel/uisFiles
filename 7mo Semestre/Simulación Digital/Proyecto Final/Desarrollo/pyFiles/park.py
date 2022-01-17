class Park:
    def __init__(self) -> None:
        self.currentTime: int = 800
        self.attractions: dict = {}


class Location:
    def __init__(self, name: str, serviceRate: int, duration: int) -> None:
        self.name: str = name
        self.serviceRate: int = serviceRate
        self.waitTime: int = 0
        self.fakeWaitTime: int = 0
        self.duration: int = 0
        self.
        

class Hub(Location):
    def __init__(self) -> None:
        super().__init__()