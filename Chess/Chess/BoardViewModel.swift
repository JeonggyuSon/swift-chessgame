//
//  BoardViewModel.swift
//  Chess
//
//  Created by kakao on 2022/06/27.
//

import Foundation

protocol BoardViewModel {
    var board: Board { get set }
    var turn: PieceColor { get set }
    var selectedPosition: Position? { get set }
    
    func piece(in position: Position?) -> Piece?
    func moveBoardSpace(position: Position) throws -> Bool
}

enum BoardSelectError: Error {
    case notSelectPiece
    case equalSelectedPositions
    case notPossiblePosition
}

final class BoardViewModelImpl: BoardViewModel {
    var board: Board = Board()
    var turn: PieceColor = .white
    var selectedPosition: Position?
    
    func piece(in position: Position?) -> Piece? {
        guard let position = position else {
            return nil
        }

        return board.piece(position: position)
    }
    
    func moveBoardSpace(position: Position) throws -> Bool {
        if let selectedPosition = selectedPosition {
            if selectedPosition == position {
                throw BoardSelectError.equalSelectedPositions
            } else {
                if board.movePiece(from: selectedPosition, to: position) {
                    self.selectedPosition = nil
                    return true
                } else {
                    throw BoardSelectError.notPossiblePosition
                }
            }
        } else {
            self.selectedPosition = position
            throw BoardSelectError.notSelectPiece
        }
    }
}
