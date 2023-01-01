//
//  main.swift
//  WorldCupDataAnalyzer
//
//  Created by Sebastian Staszczyk on 07/12/2022.
//

import Foundation

private func readWorldCupData() -> Data? {
    let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let bundleURL = URL(fileURLWithPath: "data.bundle", relativeTo: currentDirectoryURL)
    let bundle = Bundle(url: bundleURL)!
    let bundlePath = bundle.path(forResource: "worldCupData", ofType: "json")!
    let jsonData = try! String(contentsOfFile: bundlePath).data(using: .utf8)
    return jsonData
}


let worldCupData = readWorldCupData()!
let worldCup = try! JSONDecoder().decode(WorldCup.self, from: worldCupData)

var players: [EloPlayer] = []

func getPlayer(withName name: String) -> EloPlayer {
    guard let player = players.first(where: { $0.name == name }) else {
        let newPlayer = EloPlayer(name: name)
        players.append(newPlayer)
        return newPlayer
    }
    return player
}

for season in worldCup.seasons {
    for match in season.matches {
        let firstTeam = match.firstTeam
        let secondTeam = match.secondTeam

        let firstPlayer = getPlayer(withName: firstTeam.team.name)
        let secondPlayer = getPlayer(withName: secondTeam.team.name)

        firstPlayer.gameCount += 1
        secondPlayer.gameCount += 1

        let matchResult: EloAlgorithm.GameResult

        if firstTeam.score == secondTeam.score {
            matchResult = .draw
        } else {
            matchResult = .win(firstTeam.score > secondTeam.score ? firstPlayer : secondPlayer)
        }

        EloAlgorithm.updateRatingForGame(firstPlayer: firstPlayer, secondPlayer: secondPlayer, change: 5, result: matchResult)
    }
}

players.sort(by: { $0.rating > $1.rating })

for playerElement in players.enumerated() {
    let player = playerElement.element
    print("\(String(playerElement.offset + 1)). \(player.name)")
    print("Games: \(String(player.gameCount))")
    print("Rating: \(player.rating)")
    print("----------------")
}
