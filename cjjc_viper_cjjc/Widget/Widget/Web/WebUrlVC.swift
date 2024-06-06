//
//  WebUrlVC.swift
//  YiDa
//
//  Created by cjjc on 2022/8/6.
//

import UIKit

class WebUrlVC: BasicVC, WKNavigationDelegate, WKUIDelegate {
    var urlStr : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createWeb()
    }
    func createWeb(){
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = WKUserContentController()
       
        webView = WKWebView.init()
        // 允许右滑返回
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.isOpaque = false
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(barView.snp.bottom)
        }

        pLog(urlStr)
        // 加载 url
        webView.load(URLRequest(url: URL(string: urlStr)!))
        
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        pLog(message.body,message.name,message)
//        if message.name == "backApp" {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    /** **********  页面开始加载时调用  *********** */
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        HUD.showProgress("正在加载".language)
    }
    /** **********  页面加载完成之后调用 *********** */
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        HUD.hide()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        HUD.hide()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }

}
