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

    func testExample() throws {
        let board = Board()
        
        board.initailizePiece()
        board.display()
        board.printScore()
        
        let from = Position(rank: .A, file: ._1)
        let to = Position(rank: .D, file: ._3)
        board.movePiece(from: from, to: to)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
