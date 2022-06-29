//
//  BoardViewModel.swift
//  Chess
//
//  Created by kakao on 2022/06/27.
//

import Foundation
import Combine

enum BoardSelectError: Error {
    case notSelectPiece
    case equalSelectedPositions
    case notPossiblePosition
    case emptyPosition
    case notMatchTurn
}

extension PieceColor {
    func toggle() -> PieceColor {
        self == .black ? .white : .black
    }
}

final class BoardViewModel {
    private var cancellables = Set<AnyCancellable>()
    
    var board: Board
    var turn: CurrentValueSubject<PieceColor, Never>
    var selectedPosition: Position?
    
    var currentTurn: PieceColor { turn.value }
    
    init() {
        board = Board()
        turn = CurrentValueSubject<PieceColor, Never>(.white)
        
        turn.sink(receiveValue: { [weak self] turn in
            self?.board.turn = turn
        }).store(in: &cancellables)
    }
    
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
            if let piece = board.piece(position: position) {
                if piece.color == currentTurn {
                    self.selectedPosition = position
                    throw BoardSelectError.notSelectPiece
                } else {
                    throw BoardSelectError.notMatchTurn
                }
            } else {
                throw BoardSelectError.emptyPosition
            }
        }
    }
}
