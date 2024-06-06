//
//  TextBtn.swift
//  YiDa
//
//  Created by cjjc on 2022/8/4.
//

import UIKit

class TextBtn: ChainBtn {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cTitleColor(BaseColor.color_3A3A3A).cFont(BaseFont.font_14)
        self.setTitleColor(BaseColor.color_979797, for: .disabled)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
