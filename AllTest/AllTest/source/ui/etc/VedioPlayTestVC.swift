//
//  VedioPlayTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/27
//  custom header comment

import Foundation
import UIKit
import AVKit
import AVFoundation

/**
 비디오 재생 테스트
 */
class VedioPlayTestVC: UIViewController {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var timeCheckLabel: UILabel!
    var videoPlayer: AVPlayer!
    var videoPlayerViewController: AVPlayerViewController!
    
    var asset: AVAsset?
    
    override func viewDidLoad() {
//        prepareVideoURL()
        prepareVideoAsset()
    }
    
    // AVPlayer url 호출 및 AVPlayerViewController 활용
    func prepareVideoURL() {
//        // 비디오 파일명을 사용하여 비디오가 저장된 앱 내부의 파일 경로를 받아옴
//        let filePath:String? = Bundle.main.path(forResource: "Mountains", ofType: "mp4")
//        // 앱 내부의 파일명을 NSURL 형식으로 변경
//        let url = NSURL(fileURLWithPath: filePath!)
        
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fileworks.mp4") else {
            print("url 오류")
            return
        }
        // video 플레이어를 초기화 합니다.
        self.videoPlayer = AVPlayer(url: url as URL)
        
        // AVPlayerViewController를 초기화합니다.
        self.videoPlayerViewController = AVPlayerViewController()
        // playerViewController의 플레이어를 아까 만든 videoPlayer로 설정합니다.
        self.videoPlayerViewController.player = self.videoPlayer
        // playerViewController의 view를 알맞게 만듭니다.
        self.videoPlayerViewController.view.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
        
        self.videoView.addSubview(self.videoPlayerViewController.view)
//        self.videoPlayerViewController.player?.play()
        
        // 컨트롤 버튼 표시 유무
//        videoPlayerViewController.showsPlaybackControls = false
        
        
//        videoPlayerViewController.exitsFullScreenWhenPlaybackEnds = true
//        videoPlayerViewController.entersFullScreenWhenPlaybackBegins = true
        
        // 비디오 시간 표시
        let asset = AVURLAsset.init(url: url as URL)
        let duration = asset.duration.seconds
        durationLabel.text = "\(duration)"
        
//        videoPlayer.seek(to: CMTime(seconds:3.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
    
    // AVPlayer asset 호출 및 AVPlayerLayer 활용
    // AVPlayerLayer 사용시 별도로 재생 컨트롤러 구현 필요
    func prepareVideoAsset() {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fileworks.mp4") else {
            print("url 오류")
            return
        }
        
        let asset = AVAsset(url: url)
        self.asset = asset
        let playerItem = AVPlayerItem(asset: asset)
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: videoPlayer)
        playerLayer.frame = self.videoView.bounds //bounds of the view in which AVPlayer should be displayed
        playerLayer.videoGravity = .resizeAspect
        
        self.videoView.layer.addSublayer(playerLayer)
        
        videoPlayer.play()
        
        let duration = asset.duration.seconds
        durationLabel.text = "\(duration)"
        
        addTimeObserver()
    }

    func addTimeObserver() {
        // 시간 표시 및 동작 처리
        // Invoke callback every second
        let interval = CMTime(seconds:1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))

        // Queue on which to invoke the callback
        let mainQueue = DispatchQueue.main
        // 일정 주기 감지
        videoPlayer.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { (time) in
            // play 시간
            self.timeLabel.text = "\(time.seconds)"
        }
        
        var times = [NSValue]()
        let timeValue = CMTime(value: 1, timescale: 2) // 1/4 초 -> 0.25초
        times.append(NSValue(time: timeValue))
        
        if let asset = self.asset {
            let timeInterval = CMTimeMultiplyByFloat64(asset.duration, multiplier: 0.25)
            var currentTime = CMTime.zero
            while currentTime < asset.duration {
                currentTime = currentTime + timeInterval
                times.append(NSValue(time: currentTime))
            }
        }
        // 특정 시간대 동작
        videoPlayer.addBoundaryTimeObserver(forTimes: times, queue: mainQueue) {
            let form = DateFormatter()
            form.dateFormat = "HH:mm:ss"
            self.timeCheckLabel.text = form.string(from: Date())
        }
    }
    
    @IBAction func presentPlay() {
        // 비디오 파일명을 사용하여 비디오가 저장된 앱 내부의 파일 경로를 받아옴
        let filePath:String? = Bundle.main.path(forResource: "Mountains", ofType: "mp4")
        // 앱 내부의 파일명을 NSURL 형식으로 변경
        let url = NSURL(fileURLWithPath: filePath!)
        
        // AVPlayerController의 인스턴스 생성
        let playerController = AVPlayerViewController()
        // 비디오 URL로 초기화된 AVPlayer의 인스턴스 생성
        let player = AVPlayer(url: url as URL)
        // AVPlayerViewController의 player 속성에 위에서 생성한 AVPlayer 인스턴스를 할당
        playerController.player = player
        // 화면 채우는 방식
        playerController.videoGravity = .resizeAspectFill
        
        // 재생중인 비디오를 그대로 사용할 때(재생상태, 시간 유지됨)
//        playerController.player = videoPlayer
        
        self.present(playerController, animated: true){
            player.play() // 비디오 재생
        }

    }
    
    @IBAction func playView() {
        videoPlayer.seek(to: .zero)
        videoPlayer.play()
    }
    
    @IBAction func showFullScreen() {
        videoPlayer?.pause()
//         let controller = AVPlayerViewController()
        let controller = LandscapeAVPlayerController()
         controller.player = videoPlayer

         self.present(controller, animated: true) {
             DispatchQueue.main.async {
                self.videoPlayer?.play()
             }
         }
    }
    
}

class LandscapeAVPlayerController: AVPlayerViewController {
    // 강제 화면 회전을위한 코드이나 해당 방향을 inpo.plist Supported interface orientations에 추가 하지 않을 경우 오류 발생
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
}
