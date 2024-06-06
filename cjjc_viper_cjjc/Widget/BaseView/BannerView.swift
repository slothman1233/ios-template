//
//  Banner.swift
//  Example
//
//  Created by apple on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class BannerView: UIView,FSPagerViewDataSource,FSPagerViewDelegate {
    var block : ((Int) -> Void)?
    var pagerView: FSPagerView!
    var pageControl: FSPageControl!
    let transformerTypes: [FSPagerViewTransformerType] = [.crossFading,.zoomOut,.depth,.linear,.overlap,.ferrisWheel,.invertedFerrisWheel,.coverFlow,.cubic]
    var typeIndex = 0 {
        didSet {
            let type = transformerTypes[typeIndex]
            pagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                pagerView.itemSize = FSPagerView.automaticSize
                pagerView.decelerationDistance = 1
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.85)
                pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .ferrisWheel, .invertedFerrisWheel:
                pagerView.itemSize = CGSize(width: 180, height: 140)
                pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .coverFlow:
                pagerView.itemSize = CGSize(width: 220, height: 170)
                pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                pagerView.decelerationDistance = 1
            }
        }
    }
    /** **********  网络图片  *********** */
    var imageURLStringsGroup : [String]?{
        didSet{
            pageControl.numberOfPages = imageURLStringsGroup?.count ?? 0
            pagerView.reloadData()
        }
    }
    /** **********  本地图片  *********** */
    var imageNamesGroup : [String]?{
        didSet{
            pageControl.numberOfPages = imageNamesGroup?.count ?? 0
            pagerView.reloadData()
        }
    }
    /** **********  文字数组  *********** */
    var titleGroup : [String]?{
        didSet{
            pagerView.reloadData()
        }
    }
    
    var scrollDirection : FSPagerView.ScrollDirection!{
        didSet{
            pagerView.scrollDirection = scrollDirection
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        pagerView = FSPagerView.init()//FSPagerView(frame: .init(x: 0, y: 0, width: frame.size.width, height:frame.size.height))
        pagerView.dataSource = self
        pagerView.delegate = self
        
        pagerView.automaticSlidingInterval = 2.0
        pagerView.isInfinite = true
//        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.register(BannerViewCell.self, forCellWithReuseIdentifier: "cell1")
        self.addSubview(pagerView)
        pagerView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        pageControl = FSPageControl.init()//FSPageControl(frame: .init(x: 0, y: frame.size.height-20, width: frame.size.width, height: 20))
        
        pageControl.contentHorizontalAlignment = .center
        pageControl.isHidden = true
        
        self.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.bottom).offset(-20)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
        }
    }
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if titleGroup != nil {
            return titleGroup?.count ?? 0
        }
        return (imageURLStringsGroup?.count ?? (imageNamesGroup?.count ?? 0))!
    }
        
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell1", at: index) as! BannerViewCell
        if imageURLStringsGroup != nil {
            cell.img.kf.setImage(with: URL.init(string: imageURLStringsGroup?[index] ?? ""))
        }else{
            cell.img.image = imageNamesGroup?[index].image
        }
        if titleGroup != nil {
            
            if index >= titleGroup?.count ?? 0 {
                cell.lb.text = ""
            }else{
                cell.lb.text = titleGroup?[index]
            }
        }
        cell.img.contentMode = .scaleAspectFill
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        if block != nil {
            block!(index)
        }
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class BannerViewCell: FSPagerViewCell{
    
    lazy var img: UIImageView = {
        let img = initImg()
        img.contentMode = .scaleAspectFit
        contentView.addSubview(img)
        return img
    }()
    
    lazy var lb: UILabel = {
        let lb = UILabel.init()
        lb.backgroundColor = .clear
        lb.font = UIFont.systemFont(ofSize: 12)
        lb.textColor = "3a3a3a".Hex
        contentView.addSubview(lb)
        return lb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        
        img.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        lb.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.centerY.equalTo(contentView)
            make.right.greaterThanOrEqualTo(self.snp.right).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
