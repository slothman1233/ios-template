//
//  BasicHtmlVC.swift
//  YiDa
//
//  Created by cjjc on 2022/8/6.
//

import UIKit
import WebKit
class WebHtmlVC: BasicVC, WKNavigationDelegate, WKUIDelegate {
    var html : String!
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        barView.labelTitle = text
        
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
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false

        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(barView.snp.bottom)
        }

        // 加载本地html文件
//        let HTML = try! String(contentsOfFile: Bundle.main.path(forResource: "index", ofType: "html")!, encoding: String.Encoding.utf8)
        
        webView.loadHTMLString(html, baseURL: nil)
        
        // 加载 url
//        webView.load(URLRequest(url: URL(string: "https://m.xxx.com")!))
        
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
        let injectionJSString = """
            var script = document.createElement('meta');\
            script.name = 'viewport';\
            script.content="width=device-width, user-scalable=no";\
            document.getElementsByTagName('head')[0].appendChild(script);
            """
        webView.evaluateJavaScript(injectionJSString)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        HUD.hide()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }

}
