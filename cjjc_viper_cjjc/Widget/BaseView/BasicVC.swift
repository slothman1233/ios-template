//
//  BasicVC.swift
//  SwiftTest
//
//  Created by apple on 2018/7/14.
//  Copyright © 2018年 KaoLaMall. All rights reserved.
//

import UIKit

class BasicVC: UIViewController,BarViewDelegate {
    var barView : BarView!
    var ishide : Bool = true
    var backImg : UIImageView!
    var topLB : ChainLabel!
    
    var table : BaseTable!
    var coll : BaseColl!
    var scr : BaseScr!
    var webView : WKWebView!
    var userContentController : WKUserContentController!
   
    func left(btn: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func right(btn: UIButton) {
        
    }
    func label(_ label: UILabel) {

    }
    func didSelectedImage(info:[UIImagePickerController.InfoKey : Any],image: UIImage) -> Void {
        
    }
    
    var barStyle = UIStatusBarStyle.default {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .lightContent
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        pLog("\(NSStringFromClass(self.classForCoder))viewWillDisappear")
//        if !self.isKind(of: HomeVC.self) && !self.isKind(of: MineVC.self){
//            NotificationCenter.default.removeObserver(self)
//        }
        
        if let vcs = self.navigationController?.viewControllers ,  vcs.count > 1 {
            //            pLog("push进来的")
        }else{
            //            pLog("pop进来的")
            Hud.hide()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pLog("\(NSStringFromClass(self.classForCoder))进入")
    }
//    @objc func setText(){
//        if (self.isViewLoaded && !(self.view.window != nil)) {
//            self.view = nil;
//        }
//    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
//        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }
//        self.fd_prefersNavigationBarHidden = true
        
        
//        backImg = UIImageView.init(frame: .init(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
////        backImg.image = ImageWithName("create_bg")
//        backImg.backgroundColor = Hex("#F7F7F7")
//        backImg.isUserInteractionEnabled = true
//        view.addSubview(backImg)
        view.backgroundColor = Hex("#F7F7F7")
        createBar()
        
    }

    private func createBar() {
//        barView = BarView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: kTopHeight))
        barView = BarView.init()
        barView.headBackView.backgroundColor = "#ffffff".Hex
        self.view.addSubview(barView)
        barView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(44)
        }
        
        barView.leftBtnImage = "nav_back_black"
        barView.leftBtnColor = .lbColor
        barView.rightBtnColor = .lbColor
        barView.label.textColor = BaseColor.color_3A3A3A
        barView.label.font = BaseFont.font_bold_18
        barView.delegate = self
    }
    //反向传值
    func callBack(model:CallBackModel?){
        
    }
    
    deinit {
        pLog("\(NSStringFromClass(self.classForCoder))销毁")
    }
}

extension BasicVC {
    func initScr() -> BaseScr {
        
//        let cRect = rect ?? navigateRect
        let scro = BaseScr(frame: CGRect.zero)
//        scro.delegate = self
        view.addSubview(scro)
        return scro
    }
}
extension BasicVC {
    
    func initTable(style : UITableView.Style = .plain) -> BaseTable {
        
        let tableView = BaseTable.init(frame: CGRect.zero, style: style)
//        tableView.delegate = delegate
//        tableView.dataSource = delegate
        view.addSubview(tableView)
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0;
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.tableFooterView = UIView(x: 0, y: 0, width: Screen_Width, height: 0.1)
        return tableView
    }
    
    // MAEK: - table view delegate implement
}

extension BaseVC {
    
    
    func addHeader(scrollView: UIScrollView, refreshingBlock: @escaping MJRefreshComponentAction) {
        
        let header = MJRefreshNormalHeader.init(refreshingBlock: refreshingBlock)
        scrollView.mj_header = header
    }
    
    func addFooter(scrollView: UIScrollView, refreshingBlock: @escaping MJRefreshComponentAction) {
        
//        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: refreshingBlock)
        let footer = MJRefreshBackNormalFooter.init(refreshingBlock: refreshingBlock)
        scrollView.mj_footer = footer
        scrollView.mj_footer?.ignoredScrollViewContentInsetBottom = kBlankHeight
//        footer.alpha = 0
    }
    
    func endRefresh(scrollView: UIScrollView?, noMoreData: Bool = false) {
        
        if (scrollView?.mj_header?.isRefreshing == true) {
            scrollView?.mj_header?.endRefreshing()
            scrollView?.mj_footer?.state = .willRefresh
        }
        
        if (scrollView?.mj_footer?.isRefreshing == true ) {
            if noMoreData == false {
                scrollView?.mj_footer?.endRefreshing()
            } else {
                scrollView?.mj_footer?.endRefreshingWithNoMoreData()
            }
        }
    }
    
}


var isShowingAlert = false
extension UIViewController {
    
    func addView(tempView: UIView) {
        self.view.addSubview(tempView)
    }
    
    func showTip(msg: String,showCancel: Bool = false,finsihed: ((Int) -> (Void))? = nil) -> Void {
        if isShowingAlert {
            return
        }
        isShowingAlert = true
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        
        if showCancel {
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
                finsihed?(0)
                isShowingAlert = false
            }
            alert.addAction(cancel)
        }
        
        let confim = UIAlertAction(title: "确定", style: .destructive) { (action) in
            finsihed?(1)
            isShowingAlert = false

        }
        alert.addAction(confim)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    func showAlertView(alertTitle: String,msg: String,finished: @escaping ((Int,String) -> (Void))) ->Void {
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let confim = UIAlertAction(title: "确定", style: .destructive) { (action) in
            
            if let textView = alert.textFields?.first {
                if !textView.text!.isEmpty {
                   finished(1,textView.text!)
                }
            }
        }
        
        alert.addTextField { (textView) in
            textView.keyboardType = .numberPad
        }
        alert.addAction(cancel)
        alert.addAction(confim)
        self.present(alert, animated: true) {
        }
    }
    
    func showAlert(title: String = "", message: String = "", handler: ((UIAlertAction) -> Void)? = nil) {
        
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: handler)
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true)
    }
}

extension UIAlertController{
    func addActions(aItems: [UIAlertAction]) -> Void {
        for item in aItems {
            addAction(item)
        }
    }
}

extension BasicVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    /** **********  保存图片  *********** */
    func saveImage(image:UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            print("保存失败")
            Hud.showText("保存失败")
        } else {
            print("保存成功")
            Hud.showText("保存成功")
        }
    }
    func showSystemCamera(canEdit: Bool = true) -> Void {
        let alert = UIAlertController(title: "", message: "打开文件", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let camer = UIAlertAction(title: "打开相机", style: .default) { (action) in
            self.openAppCamera(sourceType: .camera,canEdit: canEdit)
        }
        let phonto = UIAlertAction(title: "打开照片", style: .default) { (action) in
            self.openAppCamera(sourceType: .photoLibrary,canEdit: canEdit)
        }
        alert.addActions(aItems: [cancel,camer,phonto])
        
        self.present(alert, animated: true) {
        }
    }
    
    // MARK: - open camera and phone
    fileprivate func openAppCamera(sourceType: UIImagePickerController.SourceType,canEdit: Bool = true) -> Void {
        
        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let name = sourceType == .camera ? "相机" : "相册"
            showTip(msg: "不能打开\(name)", showCancel: false, finsihed: { (tag) -> (Void) in
                
            })
            return
        }
//        let name = sourceType == .camera ? "相机" : "相册"
        let ctrl = UIImagePickerController()
        ctrl.sourceType = sourceType
        ctrl.allowsEditing = canEdit
        ctrl.delegate = self
        self.present(ctrl, animated: true) {
           
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {}
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            didSelectedImage(info: info, image: image)
            pLog(image)
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            didSelectedImage(info: info, image: image)
            pLog(image)
        }
    }
}

// MARK: - create sub view

extension BasicVC {
    func initLb(_ text: String = "") -> ChainLabel {
        let label = ChainLabel.init()
        label.text = text
        label.font = BaseFont.lbFont
        label.textColor = BaseColor.color_FFFFFF
        addView(tempView: label)
        label.numberOfLines = 0
        return label
    }
    
    func initTf() -> TextField {
        let textFiel = TextField.init()
        textFiel.backColor = .clear
        textFiel.autocorrectionType = .no
        textFiel.autocapitalizationType = .none
        textFiel.spellCheckingType = .no
        textFiel.placeholderColor = BaseColor.color_979797
        textFiel.font = BaseFont.tfFont
        textFiel.textColor = BaseColor.color_3A3A3A
//        textFiel.delegate = self
        textFiel.space = 5
//        textFiel.round(cornerRadius: 5)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
            textFiel.border(color: BaseColor.color_E5E5E5, borderWidth: 1, borderType: .Bottom, scale: 0)
        })
        addView(tempView: textFiel)
        return textFiel
    }
 
    func initBtn(_ text: String = "") -> ChainBtn {
        let btn = ChainBtn.init()
        btn.cTitle(text).cBackColor(.btnBackColor).cTitleColor(.btnColor).cFont(BaseFont.btnFont)
        addView(tempView: btn)
        return btn
    }
  
    func initImg() -> UIImageView {
        let imageView = UIImageView.init()
//        imageView.contentMode = .scaleAspectFit
        addView(tempView: imageView)
        
        imageView.backgroundColor = UIColor.clear
        return imageView
    }
    
    func initView(_ backColor : UIColor = Hex("f6f6f6")) -> UIView {
        let tempView = UIView.init()
        tempView.isUserInteractionEnabled = true
        addView(tempView: tempView)
        tempView.backgroundColor = backColor
        return tempView
    }
}

extension UIView{
    
    func initLb(_ text: String = "") -> ChainLabel {
        let label = ChainLabel.init()
        label.font = BaseFont.lbFont
        label.textColor = .lbColor
        label.text = text
        addSubview(label)
        label.numberOfLines = 0
        return label
    }
    
    func initTf() -> TextField {
        let textFiel = TextField.init()
        textFiel.backColor = .clear
        textFiel.autocorrectionType = .no
        textFiel.autocapitalizationType = .none
        textFiel.spellCheckingType = .no
        textFiel.placeholderColor = BaseColor.color_979797
        textFiel.font = BaseFont.tfFont
        textFiel.textColor = BaseColor.color_3A3A3A
//        textFiel.delegate = self
        textFiel.space = 5
//        textFiel.round(cornerRadius: 5)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.001, execute: {
            textFiel.border(color: BaseColor.color_E5E5E5, borderWidth: 1, borderType: .Bottom, scale: 0)
        })
        addSubview(textFiel)
        return textFiel
    }
    
    func initBtn(_ text: String = "") -> ChainBtn {
        let btn = ChainBtn.init()
        btn.cTitleColor(.btnColor).cFont(BaseFont.btnFont).cTitle(text).cBackColor(.btnBackColor)
        addSubview(btn)
        return btn
    }
    
    func initImg() -> UIImageView {
        let imageView = UIImageView.init()
//        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.backgroundColor = UIColor.clear
        return imageView
    }
    
    func initView() -> UIView {
        let tempView = UIView.init()
        tempView.isUserInteractionEnabled = true
        addSubview(tempView)
        return tempView
    }
    
    @discardableResult
    func addTapGesture(_ target: Any,_ selector: Selector) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: selector);
        addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        return tap
    }
}





