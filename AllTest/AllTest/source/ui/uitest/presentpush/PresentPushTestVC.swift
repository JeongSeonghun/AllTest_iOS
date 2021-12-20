//
//  PresentPushTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/03
//  custom header comment

import Foundation
import UIKit

/**
 ViewController present, push 테스트
 * 화면 사이즈: compact(소형, iPhone), Regular(대형, iPad)
 */
class PresentPushTestVC: UIViewController {
    
    @IBOutlet weak var vcTable: UITableView!
    @IBOutlet weak var presentStyleTable: UITableView!
    @IBOutlet weak var transitionStyleTable: UITableView!
    
    var vcList = [UIViewController]()
    var presentStyles: [UIModalPresentationStyle] { // ViewController가 표시되는 형태
        get {
            if #available(iOS 13.0, *) {
                return [.none, // present 시 직접 사용 불가
                        .currentContext,
                        .custom, // UIViewControllerTransitioningDelegater를 통해 하나 이상의 animator 관리
                        .formSheet, // iPad. 스크린보다 작은 사이즈 콘텐츠 영역을 하단에 표시
                        .fullScreen, // 전체화면으로 표시
                        .overCurrentContext,
                        .overFullScreen,
                        .pageSheet, // iPad, 세로방향은 fullscreen과 동일. 가로방향에서 너비를 세로방향 너비로 표시
                        .popover, // iPad.
                        .automatic]
            } else {
                return [.none, .currentContext, .custom, .formSheet, .fullScreen, .overCurrentContext, .overFullScreen, .pageSheet, .popover]
            }
        }
    }
    var transitionStyles: [UIModalTransitionStyle] { // ViewController가 표시되는 애니메이션 형식
        get {
            return [.coverVertical, // 아래에서 위로
                    .crossDissolve, // 교체
                    .flipHorizontal, // 좌우회전. 카드 뒤집히는 효과
                    .partialCurl] // 책넘기는 효과. present에서는 fullscreen에서만 사용 가능
        }
    }
    
    override func viewDidLoad() {
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidLoad")
        let popSB = UIStoryboard(name: "PopDismissVC", bundle: nil)
        if let popVC = popSB.instantiateInitialViewController() {
            popVC.title = "PopDismissVC"
            vcList.append(popVC)
        }
        if #available(iOS 13.0, *) {
            let vc = popSB.instantiateViewController(identifier: "TransparentVC")
            vc.title = "TransparentVC"
            vcList.append(vc)
        } else {
            let vc = popSB.instantiateViewController(withIdentifier: "TransparentVC")
            vc.title = "TransparentVC"
            vcList.append(vc)
        }
        
        vcTable.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // iOS 13 부터 present 시 modalPresentationStyle fullScreen을 직접 설정하지 않은 경우 카드뷰 형태로 표시되어 dismiss하더라도 viewWillAppear 호출안됨
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillAppear")
        _ = Util.getTopViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        // iOS 13 부터 present 시 modalPresentationStyle fullScreen을 직접 설정하지 않은 경우 카드뷰 형태로 표시되어 dismiss하더라도 viewDidAppear 호출안됨
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        // iOS 13 부터 present 시 modalPresentationStyle fullScreen을 직접 설정하지 않은 경우 카드뷰 형태로 표시되어 viewWillDisappear 호출안됨
        NSLog("\(#file.split(separator: "/").last ?? "") viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        // iOS 13 부터 present 시 modalPresentationStyle fullScreen을 직접 설정하지 않은 경우 카드뷰 형태로 표시되어 viewDidDisappear 호출안됨
        NSLog("\(#file.split(separator: "/").last ?? "") viewDidDisappear")
    }
    
    // MARK: - performSegue 테스트
    // show ( = push)
    // iOS13이상헤서 performSegue를 이용할 경우 기본적으로 card presentaion 형태로 표시
    // 전체화면이 필요한 경우 prepare에서 modalPresentationStyle을 fullScreen 혹은 overFullScreen으로 적용 필요
    @IBAction func clickSegueVCShow() {
        performSegue(withIdentifier: "segue", sender: nil)
    }
    
    // show detail. iPad가 아닐경우 present와 동일. UISpliteViewController 같이 사용
    @IBAction func clickSegueDetail() {
        performSegue(withIdentifier: "segueDetail", sender: nil)
    }
    
    // present modally ( = present)
    @IBAction func clickSeguePresent() {
        performSegue(withIdentifier: "PopDismissVC", sender: "PopDismissVC Title")
    }
    
    // present popover iPad가 아닐 경우 present와 동일
    @IBAction func clickSeguePopover() {
        performSegue(withIdentifier: "seguePopover", sender: nil)
    }
    
    // performSegue 시 호출 됨. ViewController 제어
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("prepare segue identifier: \(segue.identifier ?? "")")
        switch segue.identifier {
        case "PopDismissVC":
            if let vc = segue.destination as? PopDismissVC {
                let senderText = sender as? String
                vc.title = senderText
            }
        default:
            break
        }
    }
    
    // MARK: - Present, Push 시 modalPresentationStyle, modalTransitionStyle 테스트
    @IBAction func clickPresent() {
        guard let selectIdx = vcTable.indexPathForSelectedRow else { return }
        let vc = vcList[selectIdx.row]
        
        // iOS 13 부터 present 시 modalPresentationStyle defualt가 변경되어 fullScreen을 직접 설정하지 않은 경우 카드뷰 형태로 표시됨
        if let selectPresentIdx = presentStyleTable.indexPathForSelectedRow {
            let presentStyle = presentStyles[selectPresentIdx.row]
            // present할 때 none 사용 불가
            if presentStyle != .none {
                vc.modalPresentationStyle = presentStyle
            }
            
        }
        
        if let selectTransitionIdx = transitionStyleTable.indexPathForSelectedRow {
            let transitionStyle = transitionStyles[selectTransitionIdx.row]
            if transitionStyle == .partialCurl {
                // partialCurl은 fullscreen에서만 사용가능
                if vc.modalPresentationStyle == .fullScreen {
                    vc.modalTransitionStyle = transitionStyle
                }
            } else {
                vc.modalTransitionStyle = transitionStyle
            }
            
        }
        
        present(vc, animated: true) {
            NSLog("present complete")
        }
    }
    
    @IBAction func clickPush() {
        guard let selectIdx = vcTable.indexPathForSelectedRow else { return }
        let vc = vcList[selectIdx.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PresentPushTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == vcTable {
            return vcList.count
        } else if tableView == presentStyleTable {
            return presentStyles.count
        } else {
            return transitionStyles.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == vcTable {
            return makeVCCell(tableView: tableView, cellForRowAt: indexPath)
        } else if tableView == presentStyleTable {
            return makePresentCell(tableView: tableView, cellForRowAt: indexPath)
        } else {
            return makeTransitionCell(tableView: tableView, cellForRowAt: indexPath)
        }
    }
    
    func makeVCCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let vc = vcList[indexPath.row]
        cell.textLabel?.text = vc.title
        return cell
    }
    func makePresentCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let style = presentStyles[indexPath.row]
        switch style {
        case .automatic:
            cell.textLabel?.text = "coverVertical"
        case .currentContext:
            cell.textLabel?.text = "currentContext"
        case .custom:
            cell.textLabel?.text = "custom"
        case .formSheet:
            cell.textLabel?.text = "formSheet"
        case .fullScreen:
            cell.textLabel?.text = "fullScreen"
        case .none:
            cell.textLabel?.text = "none"
        case .overCurrentContext:
            cell.textLabel?.text = "overCurrentContext"
        case .overFullScreen:
            cell.textLabel?.text = "overFullScreen"
        case .pageSheet:
            cell.textLabel?.text = "pageSheet"
        case .popover:
            cell.textLabel?.text = "popover"
        default:
            break
        }
        return cell
    }
    func makeTransitionCell(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let style = transitionStyles[indexPath.row]
        switch style {
        case .coverVertical:
            cell.textLabel?.text = "coverVertical"
        case .crossDissolve:
            cell.textLabel?.text = "crossDissolve"
        case .flipHorizontal:
            cell.textLabel?.text = "flipHorizontal"
        case .partialCurl:
            cell.textLabel?.text = "partialCurl"
        default:
            break
        }
        return cell
    }
    
    
}
