from __future__ import annotations


class Person:
    def __init__(self, id, name: str = "Jon Arbuckle", archetype: dict = {}) -> None:
        self.id: str = id
        self.name: str = name
        self.currentLocation: str = "Hub"
        self.totalAttractions: int = 0
        self.totalWaitTime: int = 0
        self.arrivalTime: int = None
        self.departureTime: int = None
        self.archetype: dict = archetype
        self.activities: list(tuple) = []

    def flipCoin():
        pass

    def spinRoulette():
        pass

    def  
