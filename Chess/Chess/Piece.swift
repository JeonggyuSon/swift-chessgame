//
//  Picec.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation

protocol Piece {
    var max: Int { get }
    var score: Int { get }
    var icon: String { get }
}

enum BlackPiece: Piece {
    case pawn, knight, biship, luke, queen
    
    var icon: String {
        switch self {
        case .pawn:     return "\u{265F}"
        case .knight:   return "\u{265E}"
        case .biship:   return "\u{265D}"
        case .luke:     return "\u{265C}"
        case .queen:    return "\u{265B}"
        }
    }
    
    var max: Int {
        switch self {
        case .pawn:                     return 8
        case .biship, .luke, .knight:   return 2
        case .queen:                    return 1
        }
    }

    var score: Int {
        switch self {
        case .pawn:             return 1
        case .biship, .knight:  return 3
        case .luke:             return 5
        case .queen:            return 9
        }
    }
}

enum WhitePiece: Piece {
    case pawn, knight, biship, luke, queen
    
    var icon: String {
        switch self {
        case .pawn:     return "\u{2659}"
        case .knight:   return "\u{2658}"
        case .biship:   return "\u{2657}"
        case .luke:     return "\u{2656}"
        case .queen:    return "\u{2655}"
        }
    }
    
    var max: Int {
        switch self {
        case .pawn:                     return 8
        case .biship, .luke, .knight:   return 2
        case .queen:                    return 1
        }
    }
    
    var score: Int {
        switch self {
        case .pawn:             return 1
        case .biship, .knight:  return 3
        case .luke:             return 5
        case .queen:            return 9
        }
    }
}
