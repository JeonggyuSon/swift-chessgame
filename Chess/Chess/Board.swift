//
//  Board.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation

final class Board {
    var piecePosition : [[Piece?]] = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)

    func initailizePiece() {
        piecePosition = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)
        
        for rank in BoardRank.allCases {
            var pieces: [Piece?]?
            
            if rank == .A {
                let blackPieces: [BlackPiece?] = [.luke, .knight, .biship, nil, .queen, .biship, .knight, .luke]
                pieces = blackPieces
            } else if rank == .B {
                pieces = Array(repeating: BlackPiece.pawn, count: BoardRank.allCases.count)
            } else if rank == .G {
                pieces = Array(repeating: WhitePiece.pawn, count: BoardRank.allCases.count)
            } else if rank == .H {
                let whitePieces: [WhitePiece?] = [.luke, .knight, .biship, nil, .queen, .biship, .knight, .luke]
                pieces = whitePieces
            }
            
            if let pieces = pieces {
                piecePosition[rank.rawValue] = pieces
            }
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
