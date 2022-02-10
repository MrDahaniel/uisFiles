from simuPark.person import Person


class Queue:
    def __init__(self, type: str = "NORMAL") -> None:
        self.type: str = type
        self.inQueue: list[Person] = []

    def serve(self, nPeople: int):
        pass


class Activity:
    def __init__(self, name: str, popularity: int, duration: int) -> None:
        self.name: str = name
        self.duration: int = duration
        self.popularity: int = popularity


class Attraction(Activity):
    def __init__(
        self,
        name: str,
        popularity: int,
        duration: int,
        serviceRate: int,
        altQueue: str = None,
    ) -> None:
        super().__init__(name, popularity, duration)
        self.serviceRate: int = serviceRate
        self.waitTime: int = 0
        self.fakeWaitTime: int = 0
        self.queue: Queue = Queue()
        if altQueue in ["DFP", "SFP"]:
            self.altQueue: Queue = Queue(type=altQueue)

    def updateWaitTime(self):
        pass

    def updateFakeWaitTime(self):
        pass


class Park:
    def __init__(
        self,
        attractions: list[Attraction],
        activities: list[Activity],
        hoursOpen: int = 11,
    ) -> None:
        self.currentTime: int = 0
        self.closingTime: int = 60 * hoursOpen
        self.attractions: list[Attraction] = attractions
        self.activities: list[Activity] = activities

    def startDay(self, totalVisitors: int):
        pass

    def receiveVisitors(self):
        pass
