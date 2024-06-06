//
//  KfImage.swift
//  Mall
//
//  Created by cjjc on 2022/7/22.
//

import Foundation
import KingfisherWebP
extension UIImageView {
    func kfImage(_ url:String?,placeholder:String = "mine_image_head"){
        self.kf.setImage(with: URL.init(string: url ?? ""), placeholder: nil, options: [
            
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
//            .transition(.flipFromTop(1)),
//            .transition(.flipFromBottom(1)),
            .cacheOriginalImage,
            .processor(WebPProcessor.default),
            .cacheSerializer(WebPSerializer.default)
        ]) { img in
//            self.hideSkeleton()
        }
    }
}

extension UIButton{
    func kfImage(_ url:String?,placeholder:String = "shangcheng-z"){
        
        
        self.kf.setImage(with: URL.init(string: url ?? ""), for: .normal, placeholder: nil, options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
            .processor(WebPProcessor.default),
            .cacheSerializer(WebPSerializer.default)
        ], completionHandler:  { img in
            
        })
    }
    
    func kfBgImage(_ url:String?,placeholder:String = "shangcheng-z"){
        
//        self.isSkeletonable = true
//        self.showGradientSkeleton()
//        self.startSkeletonAnimation()
        
//        weak var ws = self
        self.kf.setBackgroundImage(with: URL.init(string: url ?? ""), for: .normal, placeholder: placeholder.image, options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage,
            .processor(WebPProcessor.default),
            .cacheSerializer(WebPSerializer.default)
        ], completionHandler:  { img in
//            ws?.hideSkeleton()
        })
    }
}
