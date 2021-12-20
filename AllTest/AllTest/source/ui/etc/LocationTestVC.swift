//
//  LocationTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/15
//  custom header comment

import Foundation
import UIKit
import CoreLocation

/**
 위치 테스트
 info.plist에 gps관련 key를 추가해야 합니다.
 Privacy - Location When In Use Usage Description(NSLocationWhenInUseUsageDescription)
 => 앱사용중에만 허용(포그라운드)
 Privacy - Location Always and When In Use Usage Description(NSLocationAlwaysAndWhenInUseUsageDescription)
 => 항상 허용(백그라운드). 백그라운드에서도 위치를 조회하기 위해서는 필수이며 background mode도 적용이 필요합니다.
 
 백그라운드에서 위치 동작을 위해서는 target - siging & capablilities 에서
 Background Mode를 추가 후 Location Updates를 체크해야 합니다.
 */
class LocationTestVC: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        locationManager = CLLocationManager()

        // 백그라운드 위치 조회 사용시 추가
        locationManager.allowsBackgroundLocationUpdates = true

        locationManager.delegate = self
    }
    
    @IBAction func clickStart() {
        checkPermission()
    }
    
    func checkPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            // 권한 허용
            NSLog("check permission allow")
            locationManager.startUpdatingLocation()
            break
        case .restricted, .notDetermined:
            // 아직 결정하지 않은 상태: 시스템 팝업 호출
            NSLog("check permission ready")
            // 항상 허용(백그라운드 동작). iOS 13 이상부터는 항상허용이 표시되지 않음
            // 다른 항목으로 허용했을 경우 임시 허용 상태로 백그라운드에서 위치 변경시 설정 변경 시스템 팝업 제공
            locationManager.requestAlwaysAuthorization()
            
            // 앱 사용 중 허용
//            locationManager.requestWhenInUseAuthorization()
        case .denied:
            // 거부. 권한 허용 및 거부를 한번 선택한 경우 권한 요청 팝업 제공 안됌.
            NSLog("check permission deny")
            showPermissionSettingAlert()
            break
        default:
            return
        }
    }
    
    func showPermissionSettingAlert() {
        let msg = (Bundle.main.infoDictionary?["NSLocationAlwaysAndWhenInUseUsageDescription"] as? String) ?? ""
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CONFIRM".localized(), style: .default, handler: { action in
            Util.openSetting()
        }))
        alert.addAction(UIAlertAction(title: "CANCEL".localized(), style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension LocationTestVC: CLLocationManagerDelegate {
    // 권한 변경 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let state = CLLocationManager.authorizationStatus()
        NSLog("authorization change: \(state)")
        switch state {
        case .authorizedAlways:
            NSLog("authorization change: always")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            NSLog("authorization change: in use")
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
    // 위치 변경
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("change location \(locations)")
        locationLabel.text = "\(locations)"
    }
}
