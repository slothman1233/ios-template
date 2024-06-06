//
//  PhotoChoice.swift
//  YiDa
//
//  Created by cjjc on 2022/8/8.
//

import UIKit

class PhotoChoice: UIView {
    var back : UIView!
    
    var cerameBtn : ChainBtn!
    
    var photoBtn : ChainBtn!
    
    var cancleBtn : ChainBtn!
    
    var block : ((_ images : [UIImage])->Void)?
    
    var count : Int = 1
    
    init(count:Int = 1,handle:((_ images : [UIImage])->Void)?) {
        super.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.isUserInteractionEnabled = true
        self.alpha = 0.1
        
        block = handle
        self.count = count
        
        back = initView()
        back.frame = .init(x: 0, y: Screen_Height, width: Screen_Width, height: 144+kBlankHeight)
        back.backgroundColor = BaseColor.color_F7F7F7
        self.back.corner(topLeft: 10, topRight: 10, bottomLeft: 0, bottomRight: 0)
        
        cerameBtn = initBtn("拍照")
        cerameBtn.cTitleColor(BaseColor.color_3A3A3A).cFont(Font(16)).cTarget(self, #selector(cerameBtnClick)).cBackColor(.white)
        back.addSubview(cerameBtn)
        cerameBtn.snp.makeConstraints { make in
            make.left.top.right.equalTo(back)
            make.height.equalTo(44)
        }
        
        
        photoBtn = initBtn("从手机相册选择")
        photoBtn.cTitleColor(BaseColor.color_3A3A3A).cFont(Font(16)).cTarget(self, #selector(photoBtnClick)).cBackColor(.white)
        back.addSubview(photoBtn)
        photoBtn.snp.makeConstraints { make in
            make.left.right.equalTo(back)
            make.top.equalTo(cerameBtn.snp.bottom).offset(1)
            make.height.equalTo(44)
        }
        
        let line = initLb()
        line.cBackColor("#EBEBEB".Hex)
        back.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(1)
            make.top.equalTo(cerameBtn.snp.bottom)
        }
       
        
        cancleBtn = initBtn("取消")
        cancleBtn.tag = 104
        cancleBtn.cTitleColor(BaseColor.color_3A3A3A).cFont(Font(16)).cTarget(self, #selector(removeView)).cBackColor(.white)
        back.addSubview(cancleBtn)
        cancleBtn.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.height.equalTo(44)
            make.left.equalTo(0)
            make.top.equalTo(photoBtn.snp.bottom).offset(11)
        }
        
    }
    @objc func cerameBtnClick(){
        hide()
        let camera = ZLCustomCamera()
        camera.takeDoneBlock = { [weak self] (image, videoUrl) in
            if let handle = self?.block {
                handle([image!])
//                self?.hide()
                self?.removeView()
            }
        }
        UIApplication.shared.keyWindows.rootViewController!.showDetailViewController(camera, sender: nil)
    }
    
    @objc func photoBtnClick(){
        hide()
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = count
        config.allowSelectVideo = false
        let ac = ZLPhotoPreviewSheet()
        ac.selectImageBlock = { [weak self] (results, isOriginal) in

            let images = results.compactMap { value -> UIImage in
                return value.image
            }

            if let handle = self?.block {
                print(images)
                handle(images)
//                self?.hide()
                self?.removeView()
            }
        }
        ac.showPhotoLibrary(sender: UIApplication.shared.keyWindows.rootViewController!)
    }
  
    
    func show(){
        UIApplication.shared.keyWindows.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            self.back.y = Screen_Height-0-self.back.height
        }) { (finished) in
            self.alpha = 1
        }
    }
    @objc func hide(){
//        self.removeFromSuperview()
        UIView.animate(withDuration: 0.3, animations: {
            self.back.y = Screen_Height
            self.alpha = 0
        }) { (finished) in
//            self.removeFromSuperview()
        }
    }

    @objc func removeView(){
        self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
