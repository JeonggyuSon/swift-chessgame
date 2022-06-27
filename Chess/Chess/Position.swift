//
//  Position.swift
//  Chess
//
//  Created by kakao on 2022/06/21.
//

import Foundation

enum BoardRank: Int, CaseIterable {
    static let firstAsciiValue = Character("1").asciiValue!
    
    case _1, _2, _3, _4, _5, _6, _7, _8
}

enum BoardFile: Int, CaseIterable {
    static let firstAsciiValue = Character("A").asciiValue!
    
    case A, B, C, D, E, F, G, H
}

struct Position: Equatable {
    var file: BoardFile
    var rank: BoardRank
}

extension BoardRank {
    static func - (rhs: BoardRank, lhs: Int) -> BoardRank? {
        guard let nextRank = BoardRank(rawValue: rhs.rawValue - 1) else { return nil }
        
        return nextRank
    }
    
    static func + (rhs: BoardRank, lhs: Int) -> BoardRank? {
        guard let nextRank = BoardRank(rawValue: rhs.rawValue + 1) else { return nil }
        
        return nextRank
    }
}

extension BoardFile {
    static func - (rhs: BoardFile, lhs: Int) -> BoardFile? {
        guard let nextFile = BoardFile(rawValue: rhs.rawValue - 1) else { return nil }
        
        return nextFile
    }
    
    static func + (rhs: BoardFile, lhs: Int) -> BoardFile? {
        guard let nextFile = BoardFile(rawValue: rhs.rawValue + 1) else { return nil }
        
        return nextFile
    }
}

extension Position {
    enum PositionError: Error {
        case invalidString, invalidPosition
    }
    
    init(string: String) throws {
        guard string.count == 2,
              let fileValue = string.first?.asciiValue,
              let rankValue = string.last?.asciiValue,
              fileValue >= BoardFile.firstAsciiValue && rankValue >= BoardRank.firstAsciiValue else {
            throw PositionError.invalidString
        }
        
        let rank = Int(rankValue - BoardRank.firstAsciiValue)
        let file = Int(fileValue - BoardFile.firstAsciiValue)
        
        if let rank = BoardRank(rawValue: rank), let file = BoardFile(rawValue: file) {
            self.init(file: file, rank: rank)
        } else {
            throw PositionError.invalidPosition
        }
    }
}

extension Position: Hashable {}
