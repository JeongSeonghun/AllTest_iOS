//
//  ChangeHeightCollectionView.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit

class ChangeHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
