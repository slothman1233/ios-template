//
//  SmallBtn.swift
//  YiDa
//
//  Created by cjjc on 2022/8/4.
//

import UIKit

class SmallBtn: ChainBtn {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BaseColor.color_FFFFFF
        self.round(cornerRadius: Radius.radius_btn, width: 1, borderColor: BaseColor.color_E5E5E5)
        self.cTitleColor(BaseColor.color_3A3A3A).cFont(BaseFont.font_bold_16)
        self.setTitleColor(BaseColor.color_B8B8B8, for: .highlighted)
        self.setTitleColor(BaseColor.color_C4C4C4, for: .disabled)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
