//
//  CollectionChangeHeightVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 UICollectionView 동적 높이 테스트
 */
class CollectionChangeHeightVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var arr = ["Basic Operators", "Strings and Characters", "Collection Types", "Control Flow", "Structures and Classes", "Optional Chaining", "Closures", "Automatic Reference Counting", "Advanced Operators", "Access Control", "Memory Safety", "Generics", "Protocols", "Extensions", "Type Casting", "Nested Types", "Error Handling", "Deinitialization"]
    
    override func viewDidLoad() {
        
        collectionView.layoutIfNeeded()
    }
}

extension CollectionChangeHeightVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChangeCollectionCell", for: indexPath) as! ChangeCollectionCell
        
        cell.titleLabel.text = arr[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = "collection \(indexPath.row)"
        let text = arr[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
        return CGSize(width: cellWidth, height: 30.0)
    }
}
