//
//  CollectionTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 UICollectionView Ttest
 */
class CollectionTestVC: UIViewController {
    @IBOutlet weak var oneRowCollectionView: UICollectionView!
    @IBOutlet weak var matchCollectionView: UICollectionView!
    @IBOutlet weak var twoColumCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        if let layout = twoColumCollectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

    }
}

extension CollectionTestVC: UICollectionViewDataSource, UICollectionViewDelegate {
    // CollectionView에서 보여줄 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    // CollectionnView Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == oneRowCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionOneRowCell", for: indexPath) as! CollectionOneRowCell
            var text = ""
            for _ in 0 ... indexPath.row {
                text.append("OneRow")
            }
            cell.nameLabel.text = text
            return cell
        } else if collectionView == matchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionMatchCell", for: indexPath) as! CollectionMatchCell
            cell.nameLabel.text = "Match \(indexPath.row)"
            cell.contentLabel.text = "content text content content content content content"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionTwoColumCell", for: indexPath) as! CollectionTwoColumCell
            cell.nameLabel.text = "Match \(indexPath.row)"
            cell.contentLabel.text = "content text content content content content content"
            return cell
        }
    }
    
}

extension CollectionTestVC: UICollectionViewDelegateFlowLayout {
    // cell size 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == oneRowCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionOneRowCell", for: indexPath) as! CollectionOneRowCell
            var text = ""
            for _ in 0 ... indexPath.row {
                text.append("OneRow")
            }
            cell.nameLabel.text = text
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return CGSize(width: size.width, height: 50)
        } else if collectionView == matchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionMatchCell", for: indexPath) as! CollectionMatchCell
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            return CGSize(width: matchCollectionView.frame.width, height: collectionView.frame.height)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionTwoColumCell", for: indexPath) as! CollectionTwoColumCell
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
            
            return CGSize(width: collectionView.frame.width / 2, height: 120)
        }
        
    }
}

extension CollectionTestVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
