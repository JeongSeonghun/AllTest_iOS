//
//  CollectionOrientationTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 방향 전환에 따른 UICollectionView 열 개수 변경
 */
class CollectionOrientationTestVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellsPerRow : CGFloat = 3
    let cellPadding : CGFloat = 10
    let imageRatio : CGFloat = 0.67
    
    override func viewDidLoad() {
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .compact) ? 5 : 3

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    }
}

extension CollectionOrientationTestVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionOrientationCell.identifier, for: indexPath)
        
        return cell
        
    }
}

// 스토리보드 Estimate -> none 필수
extension CollectionOrientationTestVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthMinusPadding = UIScreen.main.bounds.width - (cellPadding + cellPadding * cellsPerRow)
        let eachSide = widthMinusPadding / cellsPerRow
        return CGSize(width: eachSide, height: eachSide / imageRatio)
    }
}
