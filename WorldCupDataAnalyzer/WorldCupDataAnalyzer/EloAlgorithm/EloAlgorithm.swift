//
//  EloAlgorithm.swift
//  WorldCupDataAnalyzer
//
//  Created by Sebastian Staszczyk on 07/12/2022.
//

import Foundation

struct EloAlgorithm {

    enum GameResult {
        case win(EloPlayer)
        case draw
    }

    private static func chanceOfWinning(forPlayer ratingA: Double, vs ratingB: Double) -> Double {
        1 / (1 + pow(10,((ratingB - ratingA) / 400.0)))
    }

    static func updateRatingForGame(firstPlayer: EloPlayer, secondPlayer: EloPlayer, change: Double, result: GameResult) {
        let firstPlayerProbabilityOfWinning = chanceOfWinning(forPlayer: firstPlayer.rating, vs: secondPlayer.rating)
        let secondPlayerProbabilityOfWinning = chanceOfWinning(forPlayer: secondPlayer.rating, vs: firstPlayer.rating)

        let firstPlayerUpdatedRating: Double
        let secondPlayerUpdatedRating: Double

        switch result {
        case let .win(player):
            if player.name == firstPlayer.name {
                firstPlayerUpdatedRating = firstPlayer.rating + change * (1 - firstPlayerProbabilityOfWinning)
                secondPlayerUpdatedRating = secondPlayer.rating + change * (0 - secondPlayerProbabilityOfWinning)
            } else {
                firstPlayerUpdatedRating = firstPlayer.rating + change * (0 - firstPlayerProbabilityOfWinning)
                secondPlayerUpdatedRating = secondPlayer.rating + change * (1 - secondPlayerProbabilityOfWinning)
            }
        case .draw:
            firstPlayerUpdatedRating = firstPlayer.rating + change * (0.5 - firstPlayerProbabilityOfWinning)
            secondPlayerUpdatedRating = secondPlayer.rating + change * (0.5 - secondPlayerProbabilityOfWinning)
        }

        firstPlayer.rating = firstPlayerUpdatedRating
        secondPlayer.rating = secondPlayerUpdatedRating
    }
}
