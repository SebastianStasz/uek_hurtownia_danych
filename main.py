from models import (Team, MatchResult, Match, Season, WorldCup)
from driver import WebDriver
from data_saver import save_data
import re


class FlashScoreWorldCupScraper:

    driver = WebDriver()

    def __clear_text(self, text):
        regex = re.compile(r"[\n\r\t:]")
        clear_text = regex.sub(" ", text)
        return clear_text.strip()

    def __world_cup_page_source(self):
        return self.driver.renderPage("https://www.flashscore.pl/pilka-nozna/swiat/mistrzostwa-swiata/archiwum/")

    def __word_cup_seasons(self):
        return self.__world_cup_page_source().find(id='tournament-page-archiv').find_all(class_='archive__row')

    def __get_match(self, matchDetails: str):
        participants = matchDetails.find_all(class_='event__participant')
        scores = matchDetails.find_all(class_='event__score')
        firstTeam = Team(name=participants[0].text)
        secondTeam = Team(name=participants[1].text)
        firstTeamResult = MatchResult(team=firstTeam, score=scores[0].text)
        secondTeamResult = MatchResult(team=secondTeam, score=scores[1].text)
        return Match(firstTeam=firstTeamResult, secondTeam=secondTeamResult)

    def __get_season_matches(self, seasonDetailsLink: str):
        matchesSource = self.driver.renderPage(seasonDetailsLink).find_all(class_=['event__match', 'event__header'])
        matches = []

        for match in matchesSource:
            isClafisicationHeader = match.find(text=re.compile('Kwalifikacje')) != None
            isNotEvent = match.find(class_='event__time') == None

            if isClafisicationHeader: break
            if isNotEvent: continue

            matches.append(self.__get_match(match))

        return matches

    def scrapWorldCupData(self):
        seasons = []

        for season in self.__word_cup_seasons():
            detailsRow = season.find(class_='archive__text--clickable')
            detailsLink = 'https://www.flashscore.pl' + detailsRow['href'] + 'wyniki'
            worldCupName = self.__clear_text(detailsRow.text)
            matches = self.__get_season_matches(detailsLink)
            seasons.append(Season(name=worldCupName, matches=matches))

        return WorldCup(seasons=seasons)


def main():
    worldCupScraper = FlashScoreWorldCupScraper()
    worldCupData = worldCupScraper.scrapWorldCupData()
    save_data(worldCupData, 'test')


if __name__ == "__main__":
    main()
