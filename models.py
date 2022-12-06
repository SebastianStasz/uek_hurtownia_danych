from dataclasses import dataclass
from typing import List


@dataclass
class Team:
    name: str


@dataclass
class MatchResult:
    team: Team
    score: int


@dataclass
class Match:
    firstTeam: MatchResult
    secondTeam: MatchResult


@dataclass
class Season:
    name: str
    matches: List[Match]


@dataclass
class WorldCup:
    seasons: List[Season]
