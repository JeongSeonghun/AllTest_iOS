//
//  BluetoothTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit
import CoreBluetooth

/**
 Bluetooth 테스트
 info.pilist에 추가 필요
 Privacy - Bluetooth Always Usage Description(NSBluetoothAlwaysUsageDescription)
 Privacy - Bluetooth Peripheral Usage Description(NSBluetoothPeripheralUsageDescription)
 iOS 13부터는 권한 요청 필요 -> target 13부터는 NSBluetoothAlwaysUsageDescription 추가 필요
 target 12이하는 NSBluetoothAlwaysUsageDescription, NSBluetoothPeripheralUsageDescription 둘다 추가 필요.
 */
class BluetoothTestVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stateLabel: UILabel!
    
    var centralManager: CBCentralManager!
    var deviceList = [CBPeripheral]()
    
    override func viewDidLoad() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    @IBAction func startScan() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    @IBAction func stopScan() {
        centralManager.stopScan()
    }
}

extension BluetoothTestVC: CBCentralManagerDelegate {
    // bluetooth 연결 상태 변경
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch(central.state) {
        case .poweredOn:
            NSLog("state power On")
            stateLabel.text = "power On"
            break
        case .poweredOff:
            NSLog("state power Off")
            stateLabel.text = "power Off"
            break
        case .unsupported: // bluetooth 미지원
            NSLog("state unsupported")
            stateLabel.text = "unsupported"
            break
        case .unauthorized: // 권한 필요
            NSLog("state unauthorized")
            stateLabel.text = "unauthorized"
            break
        default:
            NSLog("state \(central.state)")
            break
        }
    }
    
    // 장치 발견
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        NSLog("discover : \(peripheral)")
        var isExist = false
        var pos = -1
        for device in deviceList {
            if device.identifier == peripheral.identifier {
                isExist = true
                pos = deviceList.firstIndex(of: peripheral) ?? -1
                break
            }
        }
        if isExist && pos >= 0 {
            deviceList.remove(at: pos)
        }
        deviceList.append(peripheral)
        tableView.reloadData()
    }
}

extension BluetoothTestVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = deviceList[indexPath.row]
        cell.textLabel?.text = item.name ?? "Unknown"
        cell.textLabel?.text?.append(" (\(item.identifier))")
        return cell
    }
    
}
