//
//  WebViewJSTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import UIKit
import WebKit

/**
 JavaScript 테스트
 */
class WebViewJSTestVC: UIViewController {
    private let JS_FUNC_SET_VER = "setVer"
    private let JS_FUNC_GET_NAME = "getName"
    private let JS_FUNC_SET_NAME = "setName"
    private let JS_FUNC_GET_NUM = "getRandomNum"
    private let JS_FUNC_SET_NUM = "setNum"
    private let JS_FUNC_SEND_DATA = "sendData"
    private let JS_FUNC_BACK = "goBack"
    private let JS_FUNC_LOG = "log"
    
    let commonProcessPool = WKProcessPool()
    
    // jsWebView, jsWebView2와 데이터 공유 확인용
    var isDataShare = false
    
    // lazy 처음 사용하기 전까지는 연산X(메모리 미차지)
    lazy var jsWebView: WKWebView = {
        // configuration은 webview가 초기화될 때에만 적용이 되므로 storyboard가 아닌 코드로 직접 구현 필요
        
        // JavaScript 와 통신을 하기 위해서 필요한 Controller
        let contentController = WKUserContentController()
        contentController.add(self, name: JS_FUNC_SET_VER) // 버전 표시
        contentController.add(self, name: JS_FUNC_GET_NAME) // 이름 전달
        contentController.add(self, name: JS_FUNC_GET_NUM) // 랜덤 숫자
        contentController.add(self, name: JS_FUNC_SET_NUM) // 랜덤 숫자 전달
        contentController.add(self, name: JS_FUNC_SEND_DATA) // data 확인
        contentController.add(self, name: JS_FUNC_BACK) // 뒤로가기
        contentController.add(self, name: JS_FUNC_LOG) // Log
        
        // 스크립트 실행
        let initScript = WKUserScript(source: String(format: "\(JS_FUNC_SET_VER)('%@')", Util.currentAppVersion() ?? ""), injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(initScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        // local storage, cookie 관리
        if isDataShare {
            configuration.processPool = commonProcessPool // webview간 데이터 공유를 할 경우 싱글톤으로 설정
        }
        
//        configuration.dataDetectorTypes = .all
        // websiteDataStore nonPersistent 설정 시 화면 재진입할 경우 locallstorage, cookie 데이터 초기화
//        configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        
        // window open 자동 실행시 동작 여부(iOS default false. false 상태인 경우 페이지 로딩 중 자동으로 window open 시 동작 안함)
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let  webview = WKWebView(frame: self.view.bounds, configuration: configuration)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        return webview
    }()
    
    // local storage, cookie 공유 확인 용
    lazy var jsWebView2: WKWebView = {
        let configuration = WKWebViewConfiguration()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: JS_FUNC_GET_NUM) // 랜덤 숫자
        configuration.userContentController = contentController
        
        // local storage, cookie 관리
        if isDataShare {
            // webview간 데이터 공유를 할 경우 싱글톤으로 설정. 설정을 하지 않을 경우 최초 생성시에는 존제하는 것을 가져오지만 이후로 공유되지 않음.
            configuration.processPool = commonProcessPool
        }
        
        let  webview = WKWebView(frame: self.view.bounds, configuration: configuration)
        webview.uiDelegate = self
        webview.navigationDelegate = self
        return webview
    }()
    
    override func viewDidLoad() {
        view.addSubview(jsWebView)
        view.addSubview(jsWebView2)
        jsWebView.translatesAutoresizingMaskIntoConstraints = false
        jsWebView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jsWebView.topAnchor.constraint(equalTo: view.topAnchor)
            , jsWebView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            , jsWebView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            , jsWebView2.topAnchor.constraint(equalTo: jsWebView.bottomAnchor)
            , jsWebView2.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            , jsWebView2.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            , jsWebView2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            , jsWebView2.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        showHtml()
        
        NotificationCenter.default.addObserver(self, selector: #selector(testReceive(_:)), name: NSNotification.Name.testDeepLinkCheck, object: nil)
        
        // long press link preview(WKWebView 미리보기 3D Touch. defualt true)
        // 웹에서 css style로 설정 가능 -> -webkit-touch-callout
//        jsWebView.allowsLinkPreview = false
        
    }
    
    @IBAction func testReceive(_ noti: NSNotification) {
        NSLog("receive data")
    }
    
    func showHtml() {
        guard let path = Bundle.main.path(forResource: "test", ofType: "html") else {
            print("path is nil")
            return
        }
        jsWebView.load(URLRequest(url : URL(fileURLWithPath: path)))
        
        guard let path2 = Bundle.main.path(forResource: "test2", ofType: "html") else {
            print("path2 is nil")
            return
        }
        jsWebView2.load(URLRequest(url : URL(fileURLWithPath: path2)))
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        // iOS15 WebView HTML select native UI가 변경. 동작 시 present가 호출되어 fullScreen 적용할 경우 black screen 발생
//        viewControllerToPresent.modalPresentationStyle = .fullScreen
        
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        NSLog("present check")
    }

}

extension WebViewJSTestVC: WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate {
    
    // MARK: - WKNavigationDelegate
    // 1. WebiVew load 혹은 웹에서 <a href> 호출 등의 상황에서 호출된다.
    // 웹 페이지 탐색 혀용 결정
    // navigationAction: url 응답 받기 전, navigationResponse: url 응답 받은 후
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("navigationAction \(navigationAction.request.url?.absoluteString ?? "")")
        // web에서 링크(href)를 통한 호출 시 동작 처리(ex. tel:, mailto:, ...)
        // 외부 앱 연동 처리 시 info LSApplicationQueriesSchemes 에 이동할 앱 scheme 추가 필요
        if let url = navigationAction.request.url, url.scheme != "http" && url.scheme != "https", UIApplication.shared.canOpenURL(url) && url.scheme != "file" {
            // simulator인 경우 file:// 로컬 파일경로로 canOpenURL호출할 경우 true를 반환함
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
            if navigationAction.navigationType == .backForward {
                // 웹 뒤로가기 판단
                print("backforward")
            }
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
    
    // 4. WebView에서 페이지 로딩 완료시 호출된다.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish \(webView.url?.absoluteString ?? "")")
        
        print("forardList cnt: \(webView.backForwardList.forwardList.count)")
        print("backList cnt: \(webView.backForwardList.backList.count)")
    }
    
    // WebView 로딩 중 실패시 호출된다.
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail \(webView.url?.absoluteString ?? "")")
    }
    
    // window open 시 호출
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // 1. 뷰를 생성하는 경우
        let frame = UIScreen.main.bounds
        //파라미터로 받은 configuration(jsWebView configuration 그대로 사용. local storage, cookie 데이터 공유됨)
        let createWebView = WKWebView(frame: frame, configuration: configuration)
        //오토레이아웃 처리
        createWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        createWebView.navigationDelegate = self
        createWebView.uiDelegate = self
        view.addSubview(createWebView)
        return createWebView
        // 2. 현재창에서 열고 싶은 경우
//        self.webView.load(navigationAction.request)
//        return nil
    }
    
    // window close 시 호출
    func webViewDidClose(_ webView: WKWebView) {
        webView.removeFromSuperview()
    }
    
    // MARK: - WKUIDelegate
    // javascript alert 사용 시 구현하지 않으면 팝업 미발생. 구현 후 completionHandler 호출하지않으면 오류 발생
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) { _ in completionHandler() }
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert);
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in completionHandler(true) }
        let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in completionHandler(false) }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let name = message.name // js 호출 함수명
        print("script didReceive : \(message.name)")
        switch name {
        case JS_FUNC_GET_NAME:
            DispatchQueue.main.async {
                let scriptText = String(format: "\(self.JS_FUNC_SET_NAME)('%@')", "testName")
                self.jsWebView.evaluateJavaScript(scriptText, completionHandler: nil)
            }
            break
        case JS_FUNC_GET_NUM:
            DispatchQueue.main.async {
                let scriptText = String(format: "\(self.JS_FUNC_SET_NUM)('%@')", String(RandomUtil.getRandomNum(max: 100)))
//                self.jsWebView.evaluateJavaScript(scriptText, completionHandler: nil)
                if let webView = message.webView { // call 한 webview에 script 실행하도록 message 에서 webview를 가져와 실행
                    webView.evaluateJavaScript(scriptText, completionHandler: nil)
                }
                
            }
            break
        case JS_FUNC_SEND_DATA:
            let body = message.body as? String
            NSLog("check data : \(body ?? "")")
            break
        case JS_FUNC_BACK:
            if jsWebView.canGoBack {
                NSLog("cancGoBack")
                jsWebView.goBack()
            }
            break
        case JS_FUNC_LOG:
            let body = message.body as? String ?? ""
            NSLog(body)
            break
        default:
            break
        }
    }

}

