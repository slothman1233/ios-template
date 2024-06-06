//
//  scan.swift
//  AVcaptureQRcode
//
//  Created by apple on 2018/7/17.
//  Copyright © 2018年 wanglupeng. All rights reserved.
//

import UIKit
import AVFoundation
typealias Block = (_ str:String) -> Void
class ScanVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var cameraView: ScannerBackgroundView!
    var callBack: Block?
    var from : String = ""
    
    func callBackBlock(block: @escaping Block) {
        
        callBack = block
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫一扫"
        
        self.view.backgroundColor = UIColor.black
        //设置导航栏
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(ScanVC.selectPhotoFormPhotoLibrary(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        //相机显示视图
        //        let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
        cameraView = ScannerBackgroundView.init(frame: UIScreen.main.bounds)
        //        cameraView.scanning = "start"
        self.view.addSubview(cameraView)
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(Int(0.1))
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.addCaptureDevice()
        }
        
    }
    func addCaptureDevice()  {
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            //初始化媒体捕捉的输入流
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            //初始化AVcaptureSession
            captureSession = AVCaptureSession()
            //设置输入到Session
            captureSession?.addInput(input)
        }  catch  {
            // 捕获到移除就退出
            print(error)
            return
        }
        
        let Output = AVCaptureMetadataOutput()
        captureSession?.addOutput(Output)
        
        //设置代理 扫描的目标设置为二维码
        Output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        Output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        captureSession?.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if  metadataObjects.count == 0 {
            return
        }
        
        // 取出第一个对象
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            _ = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            if metadataObj.stringValue != nil {
                captureSession?.stopRunning()
                print(metadataObj.stringValue!)
                callBack!(metadataObj.stringValue!)
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //从相册中选择图片
    @objc func selectPhotoFormPhotoLibrary(_ sender : AnyObject){
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerController.SourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
    
    //选择相册中的图片完成，进行获取二维码信息
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]
        
        let imageData = (image as! UIImage).pngData()
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        picker.dismiss(animated: true, completion: nil)
        if (array?.count)!>0 {
            let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature
            print(result.messageString ?? String())
            
            callBack!(result.messageString ?? String())
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            print("error")
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
