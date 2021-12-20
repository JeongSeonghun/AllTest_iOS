# AllTest_iOS

Swift 기반 iOS 개발 테스트 앱입니다.
아래와 같은 환경에서 진행했습니다.

- Xcode version : 12.5
- target version : iOS 11.0

## 사용전 준비

1) 라이브러리 관리는 cocoapods을 이용하고 있어 빌드 전 터미널에서 pod install 을 호출 해야합니다.

```Podfile
    pod install
```

- archive 시 MaterialAppBar 라이브러리 버전 이슈로 프로젝트 pod에서 해당 라이브러리 build 버전을 11.0으로 수정하거나 Pofile에 target 버전 지정할 필요가 있음

## 테스트 목록

1. [AllTest](#alltest)

    1.1 [UI Test](#ui-test)

    1.2. [Library Test](#library-test)

    1.3. [ETC Test](#etc-test)

2. [AllTestTests](#alltesttests)

3. [AllTestUITests](#alltestuitests)

4. [AllTest InnerFramework](#alltest-innerframework)

5. [AllTest StaticFramework](#alltest-staticframework)

6. [AllTest StaticLibObc](#alltest-staticlibobc)

7. [AllTest2](#alltest2)

## AllTest

테스트 앱

- swift로 구성

## UI Test

TableView, CollectionView, WebView, Alert, Picker, Tab, Container, Progress, Slider, Indicator
Animation, Custom View, Album/Camera, Label text, Paging, ViewController present/push

## Library Test

DropDown, IQKeyboardManagerSwift, SideMenu, Lottie, Toast_Swift, MaterialAppBar, Framework/Library Test

## ETC Test

LifeCycle, Format, Data save, DB, Validate pattern, App info, Target
Notification, Audio/Video play, Timer, Asset, Location, Bluetooth

## AllTestTests

Unit Test

- swift로 구성

## AllTestUITests

UI Test

- swift로 구성

## AllTest InnerFramework

Framework Test

- swift로 구성

## AllTest StaticFramework

Framework Test

- swift로 구성
- static framework 테스트

## AllTest StaticLibObc

- objeciv-c로 구성
- static library 테스트

## AllTest2

Target 및 외부 앱 연동 테스트용 앱

- swift로 구성
