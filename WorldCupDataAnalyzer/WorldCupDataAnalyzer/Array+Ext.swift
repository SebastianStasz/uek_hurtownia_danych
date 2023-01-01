//
//  Array+Ext.swift
//  WorldCupDataAnalyzer
//
//  Created by Sebastian Staszczyk on 07/12/2022.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
