//
//  BoardSpace.swift
//  Chess
//
//  Created by kakao on 2022/06/27.
//

import UIKit

final class BoardSpace: UICollectionViewCell {
    @IBOutlet weak private var pieceDisplay: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                focusBorder()
            } else {
                removeBorder()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pieceDisplay.text = ""
        removeBorder()
    }
    
    func setupPiece(_ piece: Piece?) {
        guard let piece = piece else {
            return
        }

        pieceDisplay.text = piece.icon
    }
    
    func configBackgroundColor(in indexPath: IndexPath) {
        if indexPath.section % 2 == 0 {
            backgroundColor = indexPath.item % 2 == 0 ? .white : .brown
        } else {
            backgroundColor = indexPath.item % 2 == 0 ? .brown : .white
        }
    }
    
    func focusBorder() {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.blue.cgColor
    }
    
    func removeBorder() {
        contentView.layer.borderWidth = 0
    }
}
