//
//  BaseScr.swift
//  Example
//
//  Created by apple on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BaseScr: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        keyboardDismissMode = .onDrag
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
