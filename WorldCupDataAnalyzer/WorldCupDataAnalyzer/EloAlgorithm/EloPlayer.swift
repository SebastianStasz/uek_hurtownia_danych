//
//  EloPlayer.swift
//  WorldCupDataAnalyzer
//
//  Created by Sebastian Staszczyk on 07/12/2022.
//

import Foundation

final class EloPlayer {
    let name: String
    var gameCount = 0
    var rating = 1000.0

    init(name: String) {
        self.name = name
    }
}
