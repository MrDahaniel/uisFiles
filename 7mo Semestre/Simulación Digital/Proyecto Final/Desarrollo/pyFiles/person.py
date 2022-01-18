from random import uniform
from numpy import random
from park import Location


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
    def __init__(self, id: int, name: str, archetype: Archetype) -> None:
        self.id: str = id
        self.name: str = name
        self.attractionsExperienced: int = 0
        self.totalWaitTime: int = 0
        self.arrivalTime: int = None
        self.departureTime: int = None
        self.archetype: dict = archetype
        self.thingsDone: list(str) = []

    def flipCoin(self):
        if random.uniform(low=0, high=1) < self.archetype.attractionChance:
            pass
        else:
            pass

    def spinRoulette():
        pass

    def joinQueue():
        pass
