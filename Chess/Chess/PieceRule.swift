//
//  PieceRule.swift
//  Chess
//
//  Created by kakao on 2022/06/24.
//

import Foundation

protocol PieceRule {
    var color: PieceColor { get }
    
    func movablePositions(current: Position) -> [Position]
}

extension PieceRule {
    fileprivate func leftPositions(current: Position) -> [Position] {
        let leftCount = current.file.rawValue - BoardFile.A.rawValue
        
        if leftCount == 0 {
            return []
        }
        
        return (1...leftCount).compactMap({
            guard let file = BoardFile(rawValue: current.file.rawValue - $0) else { return nil }
                
            return Position(file: file, rank: current.rank)
        })
    }
    
    fileprivate func leftTopPositions(current: Position) -> [Position] {
        let left = leftPositions(current: current)
        let top = topPositions(current: current)
        
        return zip(left, top).compactMap({ Position(file: $0.file, rank: $1.rank) })
    }
    
    fileprivate func topPositions(current: Position) -> [Position] {
        let topCount = current.rank.rawValue - BoardRank._1.rawValue
        
        if topCount == 0 {
            return []
        }
        
        return (1...topCount).compactMap({
            guard let rank = BoardRank(rawValue: current.rank.rawValue - $0) else { return nil }
            
            return Position(file: current.file, rank: rank)
        })
    }
    
    fileprivate func rightTopPositions(current: Position) -> [Position] {
        let right = rightPositions(current: current)
        let top = topPositions(current: current)
        
        return zip(right, top).compactMap({ Position(file: $0.file, rank: $1.rank) })
    }
    
    fileprivate func rightPositions(current: Position) -> [Position] {
        let rightCount = BoardFile.H.rawValue - current.file.rawValue
        
        if rightCount == 0 {
            return []
        }
        
        return (1...rightCount).compactMap({
            guard let file = BoardFile(rawValue: current.file.rawValue + $0) else { return nil }
                    
            return Position(file: file, rank: current.rank)
        })
    }
    
    fileprivate func rightBottomPositions(current: Position) -> [Position] {
        let right = rightPositions(current: current)
        let bottom = bottomPositions(current: current)
        
        return zip(right, bottom).compactMap({ Position(file: $0.file, rank: $1.rank) })
    }
    
    fileprivate func bottomPositions(current: Position) -> [Position] {
        let bottomCount = BoardRank._8.rawValue - current.rank.rawValue
        
        if bottomCount == 0 {
            return []
        }
        
        return (1...bottomCount).compactMap({
            guard let rank = BoardRank(rawValue: current.rank.rawValue + $0) else { return nil }
            
            return Position(file: current.file, rank: rank)
        })
    }
    
    fileprivate func leftBottomPositions(current: Position) -> [Position] {
        let left = leftPositions(current: current)
        let bottom = bottomPositions(current: current)
        
        return zip(left, bottom).compactMap({ Position(file: $0.file, rank: $1.rank) })
    }
}

struct PawnRule: PieceRule {
    var color: PieceColor
    
    func movablePositions(current: Position) -> [Position] {
        var newPosition = current
        var nextRank: BoardRank?
        
        switch color {
        case .white:
            nextRank = current.rank - 1
        case .black:
            nextRank = current.rank + 1
        }
        
        if let nextRank = nextRank {
            newPosition.rank = nextRank
            return [newPosition]
        } else {
            return []
        }
    }
}

struct KnightRule: PieceRule {
    var color: PieceColor
    
    func movablePositions(current: Position) -> [Position] {
        var positions: [Position] = []
        var nextRank: BoardRank?
        
        switch color {
        case .white:
            nextRank = current.rank - 1
        case .black:
            nextRank = current.rank + 1
        }
        
        if let nextRank = nextRank {
            if let leftFile = current.file - 1 {
                positions.append(Position(file: leftFile, rank: nextRank))
            }
            
            if let rightFile = current.file + 1 {
                positions.append(Position(file: rightFile, rank: nextRank))
            }
            
            return positions
        } else {
            return []
        }
    }
}

struct BishopRule: PieceRule {
    var color: PieceColor
    
    func movablePositions(current: Position) -> [Position] {
        let leftTop = leftTopPositions(current: current)
        let rightTop = rightTopPositions(current: current)
        let leftBottom = leftBottomPositions(current: current)
        let rightBottom = rightBottomPositions(current: current)
        
        return leftTop + rightTop + leftBottom + rightBottom
    }
}

struct LukeRule: PieceRule {
    var color: PieceColor
    
    func movablePositions(current: Position) -> [Position] {
        let left = leftPositions(current: current)
        let right = rightPositions(current: current)
        let top = topPositions(current: current)
        let bottom = bottomPositions(current: current)
        
        return left + right + top + bottom
    }
}

struct QueenRule: PieceRule {
    var color: PieceColor
    
    func movablePositions(current: Position) -> [Position] {
        let leftTop = leftTopPositions(current: current)
        let rightTop = rightTopPositions(current: current)
        let leftBottom = leftBottomPositions(current: current)
        let rightBottom = rightBottomPositions(current: current)
        
        let left = leftPositions(current: current)
        let right = rightPositions(current: current)
        let top = topPositions(current: current)
        let bottom = bottomPositions(current: current)
        
        return left + right + top + bottom + leftTop + rightTop + leftBottom + rightBottom
    }
}
