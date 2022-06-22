//
//  Board.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Foundation

final class Board {
    private var piecePosition : [[Piece?]] = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)
    
    var whiteScore: Int = 0
    var blackScore: Int = 0

    func initailizePiece() {
        piecePosition = Array(repeating: Array(repeating: nil,count: BoardRank.allCases.count), count: BoardFile.allCases.count)
        
        for rank in BoardRank.allCases {
            var types: [PieceType?]?
            var color: PieceColor?
            
            if rank == .A || rank == .H {
                types = [.luke, .knight, .biship, nil, .queen, .biship, .knight, .luke]
                color = rank == .A ? .black : .white
                
            } else if rank == .B || rank == .G {
                types = [.pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn, .pawn]
                color = rank == .B ? .black : .white
            }
            
            if let types = types, let color = color {
                piecePosition[rank.rawValue] = createPieces(color: color, rank: rank, for: types)
            }
        }
    }
    
    private func createPieces(color: PieceColor, rank: BoardRank, for types: [PieceType?]) -> [ChessPiece?] {
        var pieces: [ChessPiece?] = Array(repeating: nil, count: BoardFile.allCases.count)
        
        for (index, type) in types.enumerated() {
            if let file = BoardFile(rawValue: index), let type = type {
                pieces[index] = ChessPiece(color: color, type: type, position: Position(rank: rank, file: file))
            }
        }
        
        return pieces
    }
    
    func piece(position: Position) -> Piece? {
        piecePosition[position]
    }
    
    func reset() {
        whiteScore = 0
        blackScore = 0
        initailizePiece()
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
    
    func movePiece(from target: Position, to dest: Position) -> Bool {
        guard let targetPiece = piecePosition[target] else { return false }
        
        let movablePositions = targetPiece.movablePositions.filter { position in
            let destPiece = piecePosition[position]
            
            return destPiece?.color != targetPiece.color
        }
        
        if movablePositions.contains(dest) {
            var targetPiece = targetPiece
            
            targetPiece.position = dest
            piecePosition[target] = nil
            piecePosition[dest] = targetPiece
        }
        
        return movablePositions.isEmpty == false
    }
    
    func addScore(piece: Piece?) {
        guard let piece = piece else {
            return
        }

        switch piece.color {
        case .white:
            whiteScore += piece.score
        default:
            blackScore += piece.score
        }
    }
}

extension Array where Element == [Piece?] {
    subscript(position: Position) -> Piece? {
        get {
            return self[position.rank.rawValue][position.file.rawValue]
        }
        
        set {
            self[position.rank.rawValue][position.file.rawValue] = newValue
        }
    }
}
