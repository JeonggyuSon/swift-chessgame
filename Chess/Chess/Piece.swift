//
//  Picec.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation

enum PieceColor {
    case white, black
}

enum PieceType {
    case pawn, knight, bishop, luke, queen
}

protocol Piece {
    var color: PieceColor { get set }
    var type: PieceType { get set }
    var position: Position { get set }
    
    var max: Int { get }
    var score: Int { get }
    var icon: String { get }
    var rule: PieceRule { get }
}

struct ChessPiece: Piece {
    var color: PieceColor
    var type: PieceType
    var position: Position
    
    var max: Int {
        switch type {
        case .pawn:                     return 8
        case .bishop, .luke, .knight:   return 2
        case .queen:                    return 1
        }
    }

    var score: Int {
        switch type {
        case .pawn:             return 1
        case .bishop, .knight:  return 3
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
            case .bishop:   return "\u{2657}"
            case .luke:     return "\u{2656}"
            case .queen:    return "\u{2655}"
            }
        case .black:
            switch type {
            case .pawn:     return "\u{265F}"
            case .knight:   return "\u{265E}"
            case .bishop:   return "\u{265D}"
            case .luke:     return "\u{265C}"
            case .queen:    return "\u{265B}"
            }
        }
    }
    
    var rule: PieceRule {
        switch type {
        case .pawn:     return PawnRule(color: color)
        case .knight:   return KnightRule(color: color)
        case .bishop:   return BishopRule(color: color)
        case .luke:     return LukeRule(color: color)
        case .queen:    return QueenRule(color: color)
        }
    }
}
