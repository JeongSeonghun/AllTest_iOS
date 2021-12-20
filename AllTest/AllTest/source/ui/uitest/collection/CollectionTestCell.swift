//
//  CollectionTestCell.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

/**
 CollectionTestVC 테스트 Cell
 */
class CollectionOneRowCell : UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

class CollectionMatchCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}

class CollectionTwoColumCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}
