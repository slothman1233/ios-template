//
//  HomeBannerView.swift
//  YiDa
//
//  Created by cjjc on 2022/8/5.
//

import UIKit


class HomeBannerView<P:HomeBannerPresentProtocol>: BaseView<P>,HomeBannerViewProtocol {
    var banner : BannerView!
    override init(present: P) {
        super.init(present: present)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func createView() {
//        self.backgroundColor = .red
        self.round(cornerRadius: 10)
        
        banner = BannerView.init()
        
        banner.imageNamesGroup = ["home_image_guide","home_icon_logo"]
        self.addSubview(banner)
        banner.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func updateImageArray(array: [String]) {
        banner.imageURLStringsGroup = array
    }
}
