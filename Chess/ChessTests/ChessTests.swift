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
            
            XCTAssertTrue(positionA1.rank == .A && positionA1.file == ._1)
            
            let positionC4 = try Position(string: "C4")
            
            XCTAssertTrue(positionC4.rank == .C && positionC4.file == ._4)
        } catch {
            XCTFail("포지션 텍스트 파싱 실패.")
        }
        
        let positionZ1 = try? Position(string: "Z1")
        
        XCTAssertTrue(positionZ1 == nil)
    }
    
    func testMovePosition() throws {
        board.initailizePiece()
        board.display()
        
        let target = Position(rank: .B, file: ._2)
        let dest = Position(rank: .C, file: ._2)
        let pawn = board.piece(position: target)
        let positions = pawn?.movablePositions
        
        XCTAssertTrue(positions?.first == dest)
        
        let isMovePiece = board.movePiece(from: target, to: dest)
        
        XCTAssertTrue(isMovePiece)
        
        board.display()
        print("white : \(board.whiteScore)\nblack : \(board.blackScore)")
    }
}
