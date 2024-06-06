//
//  BaseColl.swift
//  Example
//
//  Created by apple on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BaseColl: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.clear
        keyboardDismissMode = .onDrag
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
