//
//  SocketTool.swift
//  Atlantis
//
//  Created by apple on 2020/4/29.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SocketRocket
enum SocketDataType: Int {
    case distributeOrder
    case cancelCall
    case orderLost
    case changeDeviceType
}
//enum SRReadyState: Int {
//    case SR_CONNECTING
//    case SR_OPEN
//    case SR_CLOSING
//    case SR_CLOSED
//}

protocol SocketRocketUtilityDelegate : AnyObject {
    func ReceiveMessage(_ message : Any!)
}
class SocketTool: NSObject,SRWebSocketDelegate {
    var socket : SRWebSocket!
    var timer : Timer!
    var heartBeat : Timer!
    var reConnectTime : TimeInterval!
    var host : String!
    var type : SocketDataType!
    
    var socketReadyState : SRReadyState{
        get {
            if socket == nil {
                return SRReadyState.CONNECTING
            }
            return socket.readyState
        }
    }
    weak var delegate : SocketRocketUtilityDelegate?
    static let instance: SocketTool = {
        
        let instance = SocketTool.init()
        
        return instance
    }()
    override init() {
        socket = SRWebSocket.init(urlRequest: URLRequest.init(url: URL.init(string: "ws://192.168.1.198:9211/websocket")!))
    }
    /** **********  连接socket  *********** */
    func SRWebSocketOpen(){
        pLog("socket连接")
        if socket == nil {
            loadInfo()
            return
        }
        if (socket.readyState == .OPEN) {
            return
        }
        
        socket.delegate = nil
        socket = nil
        loadInfo()
    }
    /** **********  初始化socket *********** */
    func loadInfo(){
//        HUD.showProgress()
//        weak var ws = self
        if Defaults.isLogin == false {
            return
        }
//        var lang = "zh"
//        if Defaults[\.userLanguage].contains("en") {
//            lang = "en"
//        }
//        if Defaults[\.userLanguage].contains("ko") {
//            lang = "ko"
//        }
//        weak var ws = self
//        Network.get(HLAPPUrl.redlogin, parameters: ["auth":Defaults.userInfo?.sessionId ?? "","lang":lang]) { (value, error) in
//            guard value != nil  else{ pLog(error ?? "0"); return
////                HUD.showText(errorStr ?? error?.localizedDescription ?? "0")
//            }
//            let json = JSON(value ?? "0")
//            pLog(json)
//            if json["code"].stringValue == "1"{
//
//                HUD.hide()
//
//                Defaults.socketID = json["userId"].stringValue
//                Defaults.socketToken = json["access_token"].stringValue
//
//                ws?.socket = SRWebSocket.init(urlRequest: URLRequest.init(url: URL.init(string: "ws://192.168.1.198:9211/websocket")!))
//
////                ws?.socket = SRWebSocket.init(urlRequest: URLRequest.init(url: URL.init(string: "wss://wschat.houseside.cn/websocket")!))
//
//                ws?.socket.delegate = self
//                ws?.socket.open()
//                ws?.cont()
//            }else{
//                HUD.showText(json["message"].stringValue)
//            }
//        }
        
//        socket = SRWebSocket.init(urlRequest: URLRequest.init(url: URL.init(string: "ws://192.168.1.198:9211/websocket")!))
        socket = SRWebSocket.init(urlRequest: URLRequest.init(url: URL.init(string: "ws://wschat.houseside.cn/websocket")!))
        socket.delegate = self
        socket.open()
        
    }
    func cont(){
        let str = (["head":"zh","url":"chat.queryUserMessage","body":[:]] as [String : Any]).string
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
            if self.socketReadyState == .OPEN{
                self.sendData(str)
            }
        })
        pLog(str)
    }
    /** **********  保持心跳链接  *********** */
    func test(){
        if socket == nil {
            return
        }
        if socket.readyState == .OPEN {
            sendData(nil)
        }
    }
    /** **********  发送心跳包  *********** */
    func sendData(_ data : Any!){
//        socket.send(data)
        do{
            try socket.send(data: data as? Data)
        }
        catch{}
    }
    /** **********  长连接关闭  *********** */
    func SRWebSocketClose() {
        if socket != nil {
            socket.close()
            socket = nil
            destoryHeartBeat()
        }
    }
    /** **********  取消心跳  *********** */
    func destoryHeartBeat(){
        if heartBeat != nil {
            heartBeat.invalidate()
            heartBeat = nil
        }
    }
    /** **********  初始化心跳  *********** */
    func initHeartBeat(){
        destoryHeartBeat()
        heartBeat = Timer.init(timeInterval: 30, target: self, selector: #selector(ping), userInfo: nil, repeats: true)
        RunLoop.current.add(heartBeat, forMode: .common)
    }
    /** **********  心跳包  *********** */
    @objc func ping(){
        if socket == nil {
            return
        }
        if socket.readyState == .OPEN {
//            socket.sendPing(nil)
            do{
                try socket.sendPing(Data.init())
            }
            catch{
                
            }
            
            test()
        }
    }
    /** **********  重连机制  *********** */
    func reConnect(){
        SRWebSocketClose()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.SRWebSocketOpen()
        })
    }
    /** **********  接受消息  *********** */
    func webSocket(_ webSocket: SRWebSocket, didReceiveMessage message: Any) {
//        pLog("接受消息 \(message ?? "")")
        handleReceivedMessage(message)
    }
    
    /** **********  socket delegate  *********** */
    func webSocketDidOpen(_ webSocket: SRWebSocket) {
        reConnectTime = 0
        initHeartBeat()
        
//        var lang = "zh"
//        if Defaults.userLanguage.contains("en") {
//            lang = "en"
//        }
//        if Defaults.userLanguage.contains("ko") {
//            lang = "ko"
//        }
//        Network.get(APPUrl.redlogin, parameters: ["auth":Defaults.userInfo?.sessionId ?? "","lang":lang]) { (value, error) in
//            guard value != nil  else{ pLog(error ?? "0"); return
//                //                HUD.showText(errorStr ?? error?.localizedDescription ?? "0")
//            }
//            let json = JSON(value ?? "0")
//            pLog(json)
//            if json["code"].stringValue == "1"{
//
//                HUD.hide()
//
//                Defaults.socketID = json["userId"].stringValue
//                Defaults.socketToken = json["access_token"].stringValue
//
//                let str = (["head":"zh","url":"user.login","body":["account":Defaults.socketID,"userToken":Defaults.socketToken]] as [String : Any]).string
//
////                webSocket.send(str)
//
//                do{
//                    try webSocket.send(string: str)
//                }catch{
//
//                }
//                pLog(str)
//
//            }else{
//                HUD.showText(json["message"].stringValue)
//            }
//        }
        pLog("************************** socket 连接成功**************************")
    }
    func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
        if webSocket == socket {
            pLog("************************** socket 连接失败************************** ")
            socket = nil
            reConnect()
        }
    }
    func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        pLog("************************** socket连接断开************************** \n code \(code) reason \(reason ?? "") wasClean \(wasClean)")
        reConnect()
    }
    func webSocket(_ webSocket: SRWebSocket, didReceivePong pongPayload: Data?) {
//        pLog(String.init(data: pongPayload, encoding: .utf8))
    }
    func handleReceivedMessage(_ message : Any!){
        delegate?.ReceiveMessage(message)
    }
//    // MARK: 字典转字符串
//   class func dicValueString(_ dic:[String : Any]) -> String?{
//        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
//        let str = String(data: data!, encoding: String.Encoding.utf8)
//        return str
//    }
//
//    // MARK: 字符串转字典
//    func stringValueDic(_ str: String) -> [String : Any]?{
//        let data = str.data(using: String.Encoding.utf8)
//        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
//            return dict
//        }
//        return nil
//    }
}
