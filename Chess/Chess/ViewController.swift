//
//  ViewController.swift
//  Chess
//
//  Created by kakao on 2022/06/20.
//

import Combine
import UIKit

class ViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var board: UICollectionView!
    @IBOutlet weak var blackScore: UILabel!
    @IBOutlet weak var whiteScore: UILabel!
    @IBOutlet weak var currentTurnDisplay: UISegmentedControl!
    
    @IBAction func resetBoard(_ sender: UIButton) {
        reset()
    }
    
    private var viewModel: BoardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = BoardViewModel()
        viewModel.board.initailizePiece()
        
        board.allowsMultipleSelection = true
        board.reloadData()
        
        initCombine()
    }
    
    private func initCombine() {
        viewModel.turn.sink(receiveValue: { [weak self] turn in
            self?.currentTurnDisplay.selectedSegmentIndex = turn == .black ? 0 : 1
        }).store(in: &cancellables)
        
        viewModel.board.whiteScore.sink(receiveValue: { [weak self] whiteScore in
            self?.whiteScore.text = "\(whiteScore)"
        }).store(in: &cancellables)
        
        viewModel.board.blackScore.sink(receiveValue: { [weak self] blackScore in
            self?.blackScore.text = "\(blackScore)"
        }).store(in: &cancellables)
    }
    
    func reset() {
        blackScore.text = "0"
        whiteScore.text = "0"
        viewModel = BoardViewModel()
        viewModel.board.initailizePiece()
        board.reloadData()
        initCombine()
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        BoardRank.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BoardFile.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoardSpace", for: indexPath) as! BoardSpace
        let piece = viewModel.piece(in: indexPath.position)
        cell.setupPiece(piece)
        cell.configBackgroundColor(in: indexPath)
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentSelectedPosition = indexPath.position else { return }
        
        do {
            if try viewModel.moveBoardSpace(position: currentSelectedPosition) {
                board.reloadData()
                viewModel.turn.send(viewModel.currentTurn.toggle())
            }
        } catch {
            if let selectError = error as? BoardSelectError {
                switch selectError {
                case .notSelectPiece:
                    viewModel.board.movablePositions(target: currentSelectedPosition).forEach({ position in
                        let indexPath = IndexPath(item: position.file.rawValue, section: position.rank.rawValue)
                        let cell = collectionView.cellForItem(at: indexPath) as! BoardSpace
                        cell.focusBorder()
                    })
                case .equalSelectedPositions, .notPossiblePosition, .emptyPosition, .notMatchTurn:
                    collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView.indexPathsForSelectedItems?.count == 0 else { return }
        
        viewModel.selectedPosition = nil
        collectionView.indexPathsForSelectedItems?.forEach({ board.deselectItem(at: $0, animated: false) })
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 9) / CGFloat(BoardFile.allCases.count)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 1)
    }
}

extension IndexPath {
    var position: Position? {
        guard let file = BoardFile(rawValue: item), let rank = BoardRank(rawValue: section) else { return nil }
        
        return Position(file: file, rank: rank)
    }
}
