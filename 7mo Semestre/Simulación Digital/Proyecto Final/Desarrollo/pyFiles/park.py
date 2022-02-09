from person import Person


class Park:
    def __init__(self) -> None:
        self.currentTime: int = 800
        self.attractions: list[Location] = []
        self.activities: list[Location] = []
        self.time: int = 0


class Activity:
    def __init__(self, name: str, popularity: int, duration: int) -> None:
        self.name: str = name
        self.duration: int = duration
        self.queue: list[Person] = []
        self.popularity: int = popularity


class Attraction(Activity):
    def __init__(
        self,
        name: str,
        popularity: int,
        duration: int,
        serviceRate: int,
    ) -> None:
        super().__init__(name, popularity, duration)
        self.serviceRate: int = serviceRate
        self.waitTime: int = 0
        self.fakeWaitTime: int = 0

    def serve(self):
        pass

    def updateWaitTime(self):
        pass

    def updateFakeWaitTime(self):
        pass
