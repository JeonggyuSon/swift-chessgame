//
//  ChessTests.swift
//  ChessTests
//
//  Created by kakao on 2022/06/20.
//

import XCTest
@testable import Chess

class ChessTests: XCTestCase {
    private var board = Board()
    
    func testInitialize() throws {
        board.initailizePiece()
        board.display()
        
        print("white : \(board.whiteScore)\nblack : \(board.blackScore)")
    }

    func testPositionParsing() throws {
        do {
            let positionA1 = try Position(string: "A1")
            
            XCTAssertTrue(positionA1.rank == ._1 && positionA1.file == .A)
            
            let positionC4 = try Position(string: "C4")
            
            XCTAssertTrue(positionC4.rank == ._4 && positionC4.file == .C)
        } catch {
            XCTFail("포지션 텍스트 파싱 실패.")
        }
        
        let positionZ1 = try? Position(string: "Z1")
        
        XCTAssertTrue(positionZ1 == nil)
    }
    
    func testMovablePositions() throws {
        board.initailizePiece()
        
        let predictedPawnPositions = [Position(file: .C, rank: ._3)]
        testPiecePositions(current: Position(file: .C, rank: ._2), predicted: predictedPawnPositions)
        testPiecePositions(current: Position(file: .B, rank: ._1), predicted: [])
        testPiecePositions(current: Position(file: .A, rank: ._1), predicted: [])
        
        for rank in BoardRank.allCases {
            for file in BoardFile.allCases {
                let position = Position(file: file, rank: rank)
                
                if let piece = board.piece(position: position) {
                    let pieceType = "[rank: \(position.rank), file: \(position.file)] \(piece.type)"
                    print("\(pieceType)\n\(board.movablePositions(target: position).compactMap({ "rank:\($0.rank) / file:\($0.file)" }).joined(separator: "\n") )")
                    print("----------------\n")
                }
            }
        }
    }
    
    private func testPiecePositions(current position: Position, predicted positions: [Position]) {
        let possiblePositions = board.movablePositions(target: position)
        
        XCTAssertTrue(Set(possiblePositions) == Set(positions))
    }
    
    func testMovePosition() throws {
        board.initailizePiece()
        board.display()
        
        let target = Position(file: .A, rank: ._2)
        let dest = Position(file: .A, rank: ._3)
        let positions = board.movablePositions(target: target)
        
        XCTAssertTrue(positions.first == dest)
        
        let isMovePiece = board.movePiece(from: target, to: dest)
        
        XCTAssertTrue(isMovePiece)
        
        board.display()
        print("white : \(board.whiteScore)\nblack : \(board.blackScore)")
    }
    
    func testScore() throws {
        let pawn = ChessPiece(color: .black, type: .pawn, position: Position(file: .A, rank: ._2))
        
        board.addScore(piece: pawn)
        
        XCTAssertTrue(board.whiteScore == pawn.score)
        
        let knight = ChessPiece(color: .black, type: .knight, position: Position(file: .B, rank: ._1))
        
        board.addScore(piece: knight)
        
        XCTAssertTrue(board.whiteScore == (pawn.score + knight.score))
    }
}
