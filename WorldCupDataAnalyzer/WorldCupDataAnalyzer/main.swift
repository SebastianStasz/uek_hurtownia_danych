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

print(worldCup)
