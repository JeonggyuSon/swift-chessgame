//
//  Picec.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation

protocol Piece {
    var color: PieceColor { get set }
    var type: PieceType { get set }
    var position: Position { get set }
    
    var max: Int { get }
    var score: Int { get }
    var icon: String { get }
    var movablePositions: [Position] { get }
}

enum PieceColor {
    case white, black
}

enum PieceType {
    case pawn, knight, biship, luke, queen
}

struct ChessPiece: Piece {
    var color: PieceColor
    var type: PieceType
    var position: Position
    
    var max: Int {
        switch type {
        case .pawn:                     return 8
        case .biship, .luke, .knight:   return 2
        case .queen:                    return 1
        }
    }

    var score: Int {
        switch type {
        case .pawn:             return 1
        case .biship, .knight:  return 3
        case .luke:             return 5
        case .queen:            return 9
        }
    }
    
    var icon: String {
        switch color {
        case .white:
            switch type {
            case .pawn:     return "\u{2659}"
            case .knight:   return "\u{2658}"
            case .biship:   return "\u{2657}"
            case .luke:     return "\u{2656}"
            case .queen:    return "\u{2655}"
            }
        case .black:
            switch type {
            case .pawn:     return "\u{265F}"
            case .knight:   return "\u{265E}"
            case .biship:   return "\u{265D}"
            case .luke:     return "\u{265C}"
            case .queen:    return "\u{265B}"
            }
        }
    }
    
    var movablePositions: [Position] {
        switch type {
        case .pawn:
            switch color {
            case .white:
                let nextRankRaw = position.rank.rawValue - 1
                
                if BoardRank.A.rawValue <= nextRankRaw, let nextRank = BoardRank(rawValue: nextRankRaw) {
                    return [Position(rank: nextRank, file: position.file)]
                }
            case .black:
                let nextRankRaw = position.rank.rawValue + 1
                
                if BoardRank.H.rawValue >= nextRankRaw, let nextRank = BoardRank(rawValue: nextRankRaw) {
                    return [Position(rank: nextRank, file: position.file)]
                }
            }
        case .knight:
            break
        case .biship:
            break
        case .luke:
            break
        case .queen:
            break
        }
        
        return []
    }
}
