//
//  ChessTests.swift
//  ChessTests
//
//  Created by kakao on 2022/06/20.
//

import XCTest
@testable import Chess

class ChessTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialize() throws {
        let board = Board()
        
        board.initailizePiece()
        board.display()
        board.printScore()
    }

    func testPositionParsing() throws {
        do {
            let positionA1 = try Position(string: "A1")
            
            XCTAssertTrue(positionA1.rank == .A && positionA1.file == ._1)
        } catch {
            XCTFail("포지션 텍스트 파싱 실패.")
        }
        
        let positionZ1 = try? Position(string: "Z1")
        
        XCTAssertTrue(positionZ1 == nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
