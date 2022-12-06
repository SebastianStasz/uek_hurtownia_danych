import Foundation

enum GameResult: Int {
    case lost = 0
    case won = 1
}

final class EloPlayer {
    var id: Int
    var rating: Double

    init(id: Int, rating: Double) {
        self.id = id
        self.rating = rating
    }
}

func chanceOfWinning(forPlayer ratingA: Double, vs ratingB: Double) -> Double {
    1 / (1 + pow(10,((ratingB - ratingA) / 400.0)))
}

func eloRating(firstPlayer: EloPlayer, secondPlayer: EloPlayer, change: Double, firstPlayerWon: Bool) {
    let firstPlayerProbabilityOfWinning = chanceOfWinning(forPlayer: firstPlayer.rating, vs: secondPlayer.rating)
    let secondPlayerProbabilityOfWinning = chanceOfWinning(forPlayer: secondPlayer.rating, vs: firstPlayer.rating)

    let firstPlayerUpdatedRating: Double
    let secondPlayerUpdatedRating: Double

    if firstPlayerWon {
        firstPlayerUpdatedRating = firstPlayer.rating + change * (1 - firstPlayerProbabilityOfWinning)
        secondPlayerUpdatedRating = secondPlayer.rating + change * (0 - secondPlayerProbabilityOfWinning)
    } else {
        firstPlayerUpdatedRating = firstPlayer.rating + change * (0 - firstPlayerProbabilityOfWinning)
        secondPlayerUpdatedRating = secondPlayer.rating + change * (1 - secondPlayerProbabilityOfWinning)
    }
    
    print(firstPlayerUpdatedRating)
    print(secondPlayerUpdatedRating)
}

// Result of algorithm campared with https://www.geeksforgeeks.org/elo-rating-algorithm/

let player1 = EloPlayer(id: 1, rating: 1200)
let player2 = EloPlayer(id: 2, rating: 1000)
let change = 30.0

eloRating(firstPlayer: player1, secondPlayer: player2, change: change, firstPlayerWon: true)
