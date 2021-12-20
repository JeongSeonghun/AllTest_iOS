//
//  WebViewTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/24
//  custom header comment

import Foundation
import UIKit
import WebKit

/**
 WKWebView 테스트
 */
class WebViewTestVC: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        webview.uiDelegate = self
        webview.navigationDelegate = self
        
        // long press link preview(WKWebView 미리보기 3D Touch. defualt true)
        // 웹에서 css style로 설정 가능 -> -webkit-touch-callout
        webview.allowsLinkPreview = false
        
        showUrl()
    }
    
    func showUrl() {
        // http를 사용하기 위해서 info.plist 수정 필요
        // App Transport Security Settings - Allow Arbitrary Loads => YES
        // (NSAppTransportSecurity - NSAllowsArbitraryLoads)
//        if let url = URL(string: "https://www.naver.com") {
        if let url = URL(string: "https://www.google.com") {
            webview.load(URLRequest(url: url))
        }
    }
    
}

extension WebViewTestVC: WKUIDelegate, WKNavigationDelegate {
    
    // MARK: - WKNavigationDelegate
    // 1. WebiVew load 혹은 웹에서 <a href> 호출 등의 상황에서 호출된다.
    // 웹 페이지 탐색 혀용 결정
    // navigationAction: url 응답 받기 전, navigationResponse: url 응답 받은 후
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("navigationAction \(navigationAction.request.url?.absoluteString ?? "")")
        // web에서 링크(href)를 통한 호출 시 동작 처리(ex. tel:, mailto:, ...)
        // 외부 앱 연동 처리 시 info LSApplicationQueriesSchemes 에 이동할 앱 scheme 추가 필요
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https", UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
        
    }
    
    // 2. 웹 컨텐츠가 WebView로 로드되기 시작할 때 호출된다
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation \(webView.url?.absoluteString ?? "")")
    }
    
    // 3. WebView에서 웹 컨텐츠를 받기 시작할 때 호출된다.
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit \(webView.url?.absoluteString ?? "")")
    }

}

