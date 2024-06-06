//
//  TextBannerView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit


class TextBannerView<P:TextBannerPresentProtocol>: BaseView<P>,TextBannerViewProtocol {
    var banner : BannerView!
    var img : UIImageView!
    var btn : ChainBtn!
    override init(present: P) {
        super.init(present: present)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createView() {
        self.backgroundColor = .white
        self.round(cornerRadius: 10)
        
        img = initImg()
        img.image = R.image.home_icon_ann()
        img.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(20)
        }
        
        btn = TextBtn.init()
        btn.cTitle("查看更多").cImage(R.image.home_icon_back()).cTitleColor(BaseColor.color_979797).cFont(BaseFont.font_12).cAlignment(.right).cTarget(self, #selector(moreClick))
        self.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.right.equalTo(-0)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(self)
            make.width.equalTo(btn.intrinsicContentSize.width+10)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
            self.btn.hw_locationAdjust(buttonMode: .Right, spacing: 0)
        })
        
        weak var ws = self
        
        banner = BannerView.init()
        banner.backgroundColor = .clear
        banner.scrollDirection = .vertical
//        banner.titleGroup = ["1","2","3"]
        banner.block = { index in
            ws?.present.itemClick(index: index)
        }
        self.addSubview(banner)
        banner.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(3)
            make.right.equalTo(btn.snp.left).offset(-3)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(self)
        }
        
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton()
//        self.startSkeletonAnimation()

        DispatchQueue.main.asyncAfter(deadline: .now()+0, execute: {
//            self.banner.titleGroup = ["111111111","22222222222","33333333333"]
            self.hideSkeleton()
        })
    }
    @objc func moreClick(){
        present.moreClick()
    }
    
    func updateGroup(titles:[String]){
        banner.titleGroup = titles
    }
    
}
