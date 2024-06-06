//
//  MainBtn.swift
//  YiDa
//
//  Created by cjjc on 2022/8/4.
//

import UIKit

class MainBtn: ChainBtn {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage.imageWithColor(BaseColor.btnBg_select), for: .highlighted)
        self.setBackgroundImage(UIImage.imageWithColor(BaseColor.btnBg_disable), for: .disabled)
        self.setBackgroundImage(UIImage.imageWithColor(BaseColor.btnBg_normal), for: .normal)
        self.round(cornerRadius: Radius.radius_btn)
        self.cTitleColor(BaseColor.color_3A3A3A).cFont(BaseFont.font_bold_16)
        self.setTitleColor(BaseColor.color_898989, for: .disabled)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
