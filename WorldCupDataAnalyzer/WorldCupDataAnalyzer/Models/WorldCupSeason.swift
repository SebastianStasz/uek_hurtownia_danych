//
//  WorldCupSeason.swift
//  WorldCupDataAnalyzer
//
//  Created by Sebastian Staszczyk on 07/12/2022.
//

import Foundation

struct WorldCupSeason: Codable {
    let name: String
    let matches: [Match]
}
