from random import uniform, randint, choices
from numpy import random
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from simuPark.park import Activity, Attraction


class Archetype:
    def __init__(
        self,
        name: str,
        maxWaitTime: int,
        minWaitTime: int,
        maxStay: int,
        minStay: int,
        attractionChance: float,
    ) -> None:
        self.name: str = name
        self.maxWaitTime: int = maxWaitTime
        self.minWaitTime: int = minWaitTime
        self.maxStay: int = maxStay
        self.minStay: int = minStay
        self.attractionChance: float = attractionChance


class Person:
    def __init__(self, id: int, arrivalTime: int, archetype: Archetype) -> None:
        # General info
        self.id: str = id
        self.timeLeftInActivity: int = 0
        self.currentActivity: str = ""

        # Used for statistics
        self.attractionsExperienced: int = 0
        self.totalWaitTime: int = 0
        self.arrivalTime: int = arrivalTime
        self.thingsDone: list[str] = []

        # Archetype defined
        self.archetype: str = archetype.name
        self.departureTime: int = (
            randint(archetype.minStay, archetype.maxStay) + arrivalTime
        )
        self.bulkTime: int = randint(archetype.minWaitTime, archetype.maxWaitTime)
        self.attractionChance: float = archetype.attractionChance

    # General functions, used in all scenarios
    def flipCoin(self):
        if random.uniform(low=0, high=1) < self.archetype.attractionChance:
            # Person chooses to do queue for an attraction
            pass
        else:
            # Person chooses to do an activity
            pass

    def spinRoulette(self, activities: list[Activity]) -> Activity:
        totalPopularity: int = sum([activity.popularity for activity in activities])
        weighedPopularity: list[float] = [
            activity.popularity / totalPopularity for activity in activities
        ]
        return choices(population=activities, weights=totalPopularity, k=1)[0]

    def joinQueue(self, attraction: Attraction, queue: str = "NORMAL"):
        pass

    def leavePark(self):
        pass

    # Disney FastPass specific
    def checkAttraction(self, attraction: Attraction):
        pass
