//
//  Util.swift
//  AllTest
//  
//  Created by jsh on 2021/08/23
//  custom header comment

import Foundation
import SystemConfiguration
import UIKit

class Util {
    /// 네트워크 상태 체크
    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
    
    /// 앱 버전 ex) 1.0
    static func currentAppVersion() -> String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String
            else {return nil}
        return version
    }
    
    /// 빌드 버전 ex) 1
    static func currentAppBuildVersion() -> String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let build = dictionary["CFBundleVersion"] as? String
            else {return nil}
        return build
    }
    
    /// 단말 uuid (앱 재설치 시 변경 됨)
    static func getDeviceId() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    /// OS 버전
    static func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /// 색상(rgb값만으로 색상을 만들기 위해)
    static func makeColor(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(displayP3Red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }

    /// 다이얼 표시
    static func call(telNum: String) {
        if let url = URL(string: "tel://\(telNum)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /// 이메일 연동 오픈
    static func openEmail(email: String) {
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    /// 숫자 천단위 구분
    static func makeDecimal(value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? "0"
    }
    
    /// 설정 화면 표시
    static func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    /// 앱 종료(재시작은 불가)
    static func appExit() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            exit(0)
        }
    }
    
    /// debug 빌드 상태 체크
    static func isDebug() -> Bool {
        // debug/release 를 구분하기 위해 전처리문 사용
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// 최상위 ViewController 확인
    static func getTopViewController() -> UIViewController? {
        if #available(iOS 15.0, *) {
            // UIApplication.shared.windows deprecated
            if let scene = UIApplication.shared.connectedScenes.first {
                if let windowScene = scene as? UIWindowScene, let rootVC =
                    windowScene.windows.first?.rootViewController {
                    NSLog("getTopViewController scen ios15")
                    return getTopViewController(rootVC: rootVC)
                }
            }
        } else if #available(iOS 13.0, *) {
            // multi window. UIApplication.shared.keyWindow deprecated
            if let window = UIApplication.shared.windows.first {
                if let rootVC = window.rootViewController {
                    NSLog("getTopViewController ios13")
                    return getTopViewController(rootVC: rootVC)
                }
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                if let rootVC = window.rootViewController {
                    NSLog("getTopViewController")
                    return getTopViewController(rootVC: rootVC)
                }
            }
        }
        return nil
    }
    private static func getTopViewController(rootVC: UIViewController) -> UIViewController? {
        if let navVC = rootVC as? UINavigationController {
            // root가 NavigationController면 topViewController 혹은 visibleViewController 확인
            if let topVC = navVC.topViewController {
                NSLog("check top nav-top")
                return getTopViewController(rootVC: topVC)
            }
        }
        if let tabVC = rootVC as? UITabBarController {
            // root가 UITabBarController면 selectedViewController확인
            if let selVC = tabVC.selectedViewController {
                NSLog("check top tab-sel")
                return getTopViewController(rootVC: selVC)
            }
        }
        if let presentVC = rootVC.presentedViewController {
            NSLog("check top presennt : \(rootVC) -> \(presentVC)")
            // presented ViewController 확인으로 최상위 까지 확인
            return getTopViewController(rootVC: presentVC)
        }
        NSLog("get top ViewController \(rootVC)")
        return rootVC
    }
}
