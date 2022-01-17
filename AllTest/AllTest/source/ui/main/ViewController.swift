//
//  ViewController.swift
//  AllTest
//
//  Created by jsh on 2021/08/20.
//

import UIKit

/**
 테스트 메인 화면
 테스트 목록 표시
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var testTab: UITabBar!
    @IBOutlet weak var testTable: UITableView!
    
    var tabList = [UITabBarItem]()
    
    /// 전체 목록
    var allList = Array<TestVCItem>()
    /// ui 테스트 목록
    var uiList = Array<TestVCItem>()
    /// libray 테스트 목록
    var libList = Array<TestVCItem>()
    /// 기타 테스트 목록
    var etcList = Array<TestVCItem>()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeItems()
        initTab()
        self.navigationController?.navigationBar.topItem?.title = "TAB_HOME".localized()
        NSLog("viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NSLog("viewDidAppear")
        // 하단 탭 메뉴 클릭 시 타이틀 변환
        self.navigationController?.navigationBar.topItem?.title = "TAB_HOME".localized()
        
        _ = Util.getTopViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NSLog("viewDidDisappear")
    }

}

// 상단 텝 초기화
extension ViewController {
    func initTab() {
        tabList.append(UITabBarItem(title: "\("TAB_ALL".localized()) (\(allList.count))", image: nil, tag: 0))
        tabList.append(UITabBarItem(title: "\("TAB_UI".localized()) (\(uiList.count))", image: nil, tag: 1))
        tabList.append(UITabBarItem(title: "\("TAB_LIBRARY".localized()) (\(libList.count))", image: nil, tag: 2))
        tabList.append(UITabBarItem(title: "\("TAB_ETC".localized()) (\(etcList.count))", image: nil, tag: 3))
        
        testTab.items = tabList
        testTab.selectedItem = tabList[0]
        
        testTable.reloadData()
    }
    
    func makeItems() {
        // ui
        uiList.append(TestVCItem(storyboardName: "TableViewTestVC", title: "TITLE_TABLEVIEW_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "TableHeaderTestVC", title: "TITLE_TABLE_HEADER_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "TableChangeHeightVC", title: "TITLE_TABLE_CHANGE_HEIGHT_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "TableExpandCellTestVC", title: "TITLE_TABLE_EXPAND_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "TextTestVC", title: "TITLE_TEXT_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "WebViewTestVC", title: "TITLE_WEBVIEW_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "WebViewJSTestVC", title: "TITLE_WEBVIEW_JS_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "CollectionTestVC", title: "TITLE_COLLECTION_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "CollectionChangeHeightVC", title: "TITLE_COLLECTION_CHANGE_HEIGHT_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "CollectionOrientationTestVC", title: "TITLE_COLLECTION_ORIENTATION_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "CustomViewTestVC", title: "TITLE_CUSTOMVIEW_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "AlertTestVC", title: "TITLE_ALERT_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "ImageSelectTestVC", title: "TITLE_IMAGE_SELECT_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "PagingTestVC", title: "TITLE_PAGING_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "PresentPushTestVC", title: "TITLE_PRESENT_PUSH_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "PickerTestVC", title: "TITLE_PICKER_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "TabControllerTestVC", title: "TITLE_TABBARCONTROLLER_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "AnimationTestVC", title: "TITLE_ANIMATION_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "PropertyAnimatorTestVC", title: "TITLE_PROPERTY_ANIMATOR_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "ContainerTestVC", title: "TITLE_CONTAINER_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "ProgressTestVC", title: "TITLE_PROGRESS_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "IndicatorTestVC", title: "TITLE_INDICATOR_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "SliderTestVC", title: "TITLE_SLIDER_TEST".localized()))
        uiList.append(TestVCItem(storyboardName: "AppBarTestVC", title: "TITLE_APPBAR_TEST".localized()))
        
        // library
        libList.append(TestVCItem(storyboardName: "DropDownTestVC", title: "TITLE_DROPDOWN_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "KeyboardTestVC", title: "TITLE_KEYBOARD_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "SideMenuTestVC", title: "TITLE_SIDEMENU_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "LottieTestVC", title: "TITLE_LOTTIE_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "ToastTestVC", title: "TITLE_TOAST_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "FrameworkTestVC", title: "TITLE_FRAMEWORK_TEST".localized()))
        libList.append(TestVCItem(storyboardName: "MaterialTopBarVC", title: "TITLE_MATEREAL_TOP_BAR_TEST".localized()))
        
        // etc
        etcList.append(TestVCItem(storyboardName: "LifeCycleTestVC", title: "TITLE_LIFECYCLE_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "FormatTestVC", title: "TITLE_FORMAT_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "DataTestVC", title: "TITLE_DATA_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "DataSaveTestVC", title: "TITLE_DATA_SAVE_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "CheckValidateTestVC", title: "TITLE_VALIDATE_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "VedioPlayTestVC", title: "TITLE_VEDIO_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "AudioPlayTestVC", title: "TITLE_AUDIO_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "DelayTimerTestVC", title: "TITLE_DELAY_TIMER_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "AssetTestVC", title: "TITLE_ASSET_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "AppInfoVC", title: "TITLE_APP_INFO".localized()))
        etcList.append(TestVCItem(storyboardName: "NotificationTestVC", title: "TITLE_NOTIFICATION_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "LocationTestVC", title: "TITLE_LOCATION_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "BluetoothTestVC", title: "TITLE_BLUETOOTH_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "TargetTestVC", title: "TITLE_TARGET_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "QuickActionTestVC", title: "TITLE_QUICK_ACTION_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "EncryptionTestVC", title: "TITLE_ENCRYPTION_TEST".localized()))
        etcList.append(TestVCItem(storyboardName: "BackgroundTestVC", title: "TITLE_BACKGROUND_TEST".localized()))
        
        allList.append(contentsOf: uiList)
        allList.append(contentsOf: libList)
        allList.append(contentsOf: etcList)
//        sortList()
    }
    
    func sortList() {
        allList.sort { $0.title < $1.title }
        uiList.sort { $0.title < $1.title }
        libList.sort { $0.title < $1.title }
        etcList.sort { $0.title < $1.title }
    }
    
    func getItme(pos: Int) -> TestVCItem? {
        var item: TestVCItem?
        switch testTab.selectedItem?.tag ?? 1 {
        case 0:
            item = allList[pos]
        case 1:
            item = uiList[pos]
        case 2:
            item = libList[pos]
        case 3:
            item = etcList[pos]
        default:
            item = nil
        }
        return item
    }
}

// MARK: - 상단 테스트 유형 탭 메뉴 처리
extension ViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NSLog("tabBar didSelect \(item)")
        testTable.reloadData()
    }
}

// MARK: - 테스트 목록 처리
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch testTab.selectedItem?.tag ?? 0 {
        case 0:
            return allList.count
        case 1:
            return uiList.count
        case 2:
            return libList.count
        case 3:
            return etcList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = getItme(pos: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestVCItemCell", for: indexPath) as! TestVCItemCell

        if let item = item {
            cell.titleLabel.text = item.title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = getItme(pos: indexPath.row)
        
        if let item = item {
            let storyboard = UIStoryboard(name: item.storyboardName, bundle: nil)
            
            if let vc = storyboard.instantiateInitialViewController() {
                vc.title = item.title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

/// 테스트 목록 Cell
class TestVCItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
}

/// 테스트 목록 데이터
/// - storyboardName: 이동할 ViewControler Storyboard 명칭
/// - title: 이동할 ViewControlelr 표시 타이틀명
struct TestVCItem {
    var storyboardName: String
    var title: String
}
