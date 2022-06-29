//
//  Board.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation
import Combine

final class Board {
    private var pieceSpaces: [Position: Piece] = [:]
    
    var turn: PieceColor = .white
    var whiteScore = CurrentValueSubject<Int, Never>(0)
    var blackScore = CurrentValueSubject<Int, Never>(0)

    func initailizePiece() {
        pieceSpaces = [:]
        
        for rank in BoardRank.allCases {
            var types: [BoardFile: PieceType]?
            var color: PieceColor?
            
            if rank == ._1 || rank == ._8 {
                types = [.A: .luke, .B: .knight, .C: .bishop, .E: .queen, .F: .bishop, .G: .knight, .H: .luke]
                color = rank == ._1 ? .black : .white
                
            } else if rank == ._2 || rank == ._7 {
                types = [.A: .pawn, .B: .pawn, .C: .pawn, .D: .pawn, .E: .pawn, .F: .pawn, .G: .pawn, .H: .pawn]
                color = rank == ._2 ? .black : .white
            }
            
            if let types = types, let color = color {
                types.forEach({ (file, type) in
                    let position = Position(file: file, rank: rank)
                    pieceSpaces[position] = ChessPiece(color: color, type: type, position: position)
                })
            }
        }
    }
    
    func piece(position: Position) -> Piece? {
        pieceSpaces[position]
    }
    
    func display() {
        for rank in BoardRank.allCases {
            var rankString = ""
            
            for file in BoardFile.allCases {
                let position = Position(file: file, rank: rank)
                let pieceIcon = pieceSpaces[position]?.icon ?? "."
                
                rankString += pieceIcon
            }
            
            print("\(rankString)\n")
        }
    }
    
    func movablePositions(target: Position) -> [Position] {
        guard let targetPiece = pieceSpaces[target] else { return [] }
        
        var positions: [[Position]] = []
        
        targetPiece.rule.movablePositions(current: target).forEach { positionsByDirection in
            var filteredPositions = [Position]()
            
            for position in positionsByDirection {
                let destPiece = pieceSpaces[position]
                
                if let destPiece = destPiece {
                    if targetPiece.color != destPiece.color {
                        filteredPositions.append(position)
                    }
                    
                    break
                } else {
                    filteredPositions.append(position)
                }
            }
            
            positions.append(filteredPositions)
        }
        
        return positions.flatMap({ $0 })
    }
    
    func movePiece(from target: Position, to dest: Position) -> Bool {
        guard let targetPiece = pieceSpaces[target] else { return false }
        
        let movablePositions = movablePositions(target: target)
        
        if movablePositions.contains(dest) {
            var targetPiece = targetPiece
            let destPiece = pieceSpaces[dest]
            
            targetPiece.position = dest
            pieceSpaces.removeValue(forKey: target)
            pieceSpaces[dest] = targetPiece
            
            addScore(piece: destPiece)
        }
        
        return movablePositions.contains(dest)
    }
    
    func addScore(piece: Piece?) {
        guard let piece = piece else {
            return
        }

        switch piece.color {
        case .black:
            whiteScore.send(whiteScore.value + piece.score)
        case .white:
            blackScore.send(blackScore.value + piece.score)
        }
    }
}
