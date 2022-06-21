//
//  Position.swift
//  Chess
//
//  Created by kakao on 2022/06/21.
//

import Foundation

enum BoardRank: Int, CaseIterable {
    case A, B, C, D, E, F, G, H
}

enum BoardFile: Int, CaseIterable {
    case _1, _2, _3, _4, _5, _6, _7, _8
}

struct Position {
    let rank: BoardRank
    let file: BoardFile
}

extension Position {
    enum PositionError: Error {
        case invalidString, invalidPosition
    }
    
    init(string: String) throws {
        guard string.count == 2,
              let rankValue = string.first?.asciiValue,
              let fileValue = string.last?.asciiValue else {
            throw PositionError.invalidString
        }
        
        let rank = Int(rankValue - Character("A").asciiValue!)
        let file = Int(fileValue - Character("1").asciiValue!)
        
        if let rank = BoardRank(rawValue: rank), let file = BoardFile(rawValue: file) {
            self.init(rank: rank, file: file)
        } else {
            throw PositionError.invalidPosition
        }
    }
}
