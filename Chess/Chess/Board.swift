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
                let blackPieces: [ChessPiece?] = [ChessPiece(color: .black, type: .luke),
                                                  ChessPiece(color: .black, type: .knight),
                                                  ChessPiece(color: .black, type: .biship),
                                                  nil,
                                                  ChessPiece(color: .black, type: .queen),
                                                  ChessPiece(color: .black, type: .biship),
                                                  ChessPiece(color: .black, type: .knight),
                                                  ChessPiece(color: .black, type: .luke)]
                pieces = blackPieces
            } else if rank == .B {
                pieces = Array(repeating: ChessPiece(color: .black, type: .pawn), count: BoardRank.allCases.count)
            } else if rank == .G {
                pieces = Array(repeating: ChessPiece(color: .white, type: .pawn), count: BoardRank.allCases.count)
            } else if rank == .H {
                let whitePieces: [ChessPiece?] = [ChessPiece(color: .white, type: .luke),
                                                  ChessPiece(color: .white, type: .knight),
                                                  ChessPiece(color: .white, type: .biship),
                                                  nil,
                                                  ChessPiece(color: .white, type: .queen),
                                                  ChessPiece(color: .white, type: .biship),
                                                  ChessPiece(color: .white, type: .knight),
                                                  ChessPiece(color: .white, type: .luke)]
                pieces = whitePieces
            }
            
            if let pieces = pieces {
                piecePosition[rank.rawValue] = pieces
            }
        }
    }
    
    func score() -> (white: Int, black: Int) {
        var whiteScore: Int = 0
        var blackScore: Int = 0
        for piece in piecePosition.flatMap({ $0 }) {
            if let piece = piece {
                switch piece.color {
                case .white:    whiteScore += piece.score
                case .black:    blackScore += piece.score
                }
            }
        }
        
        return (white: whiteScore, black: blackScore)
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
