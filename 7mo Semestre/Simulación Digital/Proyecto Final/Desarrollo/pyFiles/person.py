import imp
from park import Location


class Archetype:
    def __init__(self) -> None:
        pass


class Person:
    def __init__(self, id, name: str = "Jon Arbuckle", archetype: dict = {}) -> None:
        self.id: str = id
        self.name: str = name
        self.attractionsExperienced: int = 0
        self.totalWaitTime: int = 0
        self.arrivalTime: int = None
        self.departureTime: int = None
        self.archetype: dict = archetype
        self.activities: list(tuple) = []

    def flipCoin():
        pass

    def spinRoulette():
        pass

    def joinQueue():
        pass
