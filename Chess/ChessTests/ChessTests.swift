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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
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
        
        let predictedLuckPositions = [Position(file: .B, rank: ._1), Position(file: .C, rank: ._1), Position(file: .D, rank: ._1),
                                      Position(file: .E, rank: ._1), Position(file: .F, rank: ._1), Position(file: .G, rank: ._1),
                                      Position(file: .H, rank: ._1), Position(file: .A, rank: ._2), Position(file: .A, rank: ._3),
                                      Position(file: .A, rank: ._4), Position(file: .A, rank: ._5), Position(file: .A, rank: ._6),
                                      Position(file: .A, rank: ._7), Position(file: .A, rank: ._8)]
        testPiecePositions(current: Position(file: .A, rank: ._1), predicted: predictedLuckPositions)
        
        let predictedPawnPositions = [Position(file: .C, rank: ._3)]
        testPiecePositions(current: Position(file: .C, rank: ._2), predicted: predictedPawnPositions)
        
        let predictedKnightPositions = [Position(file: .A, rank: ._2), Position(file: .C, rank: ._2)]
        testPiecePositions(current: Position(file: .B, rank: ._1), predicted: predictedKnightPositions)
        
        for rank in BoardRank.allCases {
            for file in BoardFile.allCases {
                let position = Position(file: file, rank: rank)
                
                if let piece = board.piece(position: position) {
                    let pieceType = "[rank: \(position.rank), file: \(position.file)] \(piece.type)"
                    print("\(pieceType)\n\(piece.rule.movablePositions(current: position).compactMap({ "rank:\($0.rank) / file:\($0.file)" }).joined(separator: "\n") )")
                    print("----------------\n")
                }
            }
        }
    }
    
    private func testPiecePositions(current position: Position, predicted positions: [Position]) {
        let luck = board.piece(position: position)
        let possiblePositions = luck?.rule.movablePositions(current: position) ?? []
        
        XCTAssertTrue(Set(possiblePositions) == Set(positions))
    }
    
    func testMovePosition() throws {
        board.initailizePiece()
        board.display()
        
        let target = Position(file: .A, rank: ._2)
        let dest = Position(file: .A, rank: ._3)
        let pawn = board.piece(position: target)
        let positions = pawn?.rule.movablePositions(current: target)
        
        XCTAssertTrue(positions?.first == dest)
        
        let isMovePiece = board.movePiece(from: target, to: dest)
        
        XCTAssertTrue(isMovePiece)
        
        board.display()
        print("white : \(board.whiteScore)\nblack : \(board.blackScore)")
    }
}
