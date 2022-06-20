//
//  Board.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
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

class Board {
    var piecePosition : [[Piece?]] = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)

    func initailizePiece() {
        piecePosition = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)
        
        let blackPieces: [BlackPiece?] = [.luke, .knight, .biship, nil, .queen, .biship, .knight, .luke]
        piecePosition[0] = blackPieces
        
        for file in 0..<piecePosition[1].count {
            piecePosition[1][file] = BlackPiece.pawn
        }
        
        let whitePieces: [WhitePiece?] = [.luke, .knight, .biship, nil, .queen, .biship, .knight, .luke]
        piecePosition[7] = whitePieces
        
        for file in 0..<piecePosition[6].count {
            piecePosition[6][file] = WhitePiece.pawn
        }
    }
    
    func printScore() {
        let whiteScore = piecePosition.reduce(0, { $0 + $1.reduce(0, { $0 + (($1 as? WhitePiece)?.score ?? 0) })})
        let blackScore = piecePosition.reduce(0, { $0 + $1.reduce(0, { $0 + (($1 as? BlackPiece)?.score ?? 0) })})
        
        print("white : \(whiteScore)\nblack : \(blackScore)")
    }
    
    func display() {
        for rank in 0..<piecePosition.count {
            var rankString = ""
            
            for file in 0..<piecePosition[rank].count {
                let pieceIcon = piecePosition[rank][file]?.icon ?? "."
                
                rankString += pieceIcon
            }
            
            print("\(rankString)\n")
        }
    }
    
    func createPiece(position: Position, piece: Piece) {
        
    }
    
    func movePiece(from target: Position, to dest: Position) {
        
    }
}
