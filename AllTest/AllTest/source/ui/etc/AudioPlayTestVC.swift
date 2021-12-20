//
//  AudioPlayTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/08/31
//  custom header comment

import Foundation
import UIKit
import AVFoundation

/**
 오디오(MP3) 재생 테스트
 AVAudioPlayer활용. steaming 불가
 streaming 필요 시 AVPlayer 사용
 */
class AudioPlayTestVC: UIViewController {
    @IBOutlet weak var playerSlider: UISlider!
    @IBOutlet weak var playTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var volumeLabel: UILabel!
    
    var player: AVAudioPlayer! // streaming 미지원 -> streaming 필요 시 AVPlayer 사용
    var progressTimer: Timer!
    
    let timePlayerSelector:Selector = #selector(AudioPlayTestVC.updatePlayTime)
    
    let MAX_VOLUME:Float = 10.0
    
    override func viewDidLoad() {
        initAudio()
    }
    
    func initAudio() {
        guard let audioUrl = Bundle.main.url(forResource: "Test", withExtension: "mp3") else {
            NSLog("file not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: audioUrl)
        } catch {
            NSLog(error.localizedDescription)
            return
        }
        
        player.delegate = self
        player.prepareToPlay()
        
        player.volume = 1.0
        
        volumeSlider.maximumValue = MAX_VOLUME
        volumeSlider.value = player.volume
        volumeLabel.text = "\(player.volume)"
        
        playTimeLabel.text = makeTimeText(0)
        endTimeLabel.text = makeTimeText(player.duration)
        
        playerSlider.maximumValue = Float(player.duration)
    }
    
    func makeTimeText(_ interval: TimeInterval) -> String {
        let min = Int(interval/60)
        let sec = Int(interval.truncatingRemainder(dividingBy: 60))
        return "\(min):\(sec)"
    }
    
    @IBAction func clickPlay() {
        if player == nil { return }

        if player.play() {
            NSLog("play success")
            if progressTimer == nil || !progressTimer.isValid {
                progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
            }
            
        } else {
            NSLog("play fail")
        }
    }

    @objc func updatePlayTime(){
        playTimeLabel.text = makeTimeText(player.currentTime)
        playerSlider.value = Float(player.currentTime)
    }
    
    @IBAction func clickPause() {
        if player == nil { return }
        player.pause()
    }
    
    @IBAction func clickStop() {
        if player == nil { return }
        player.stop()
        player.currentTime = 0
        playTimeLabel.text = makeTimeText(0)
        playerSlider.value = 0
        progressTimer.invalidate()
    }
    
    @IBAction func changedTimeSlider(sender: UISlider) {
        if player == nil { return }
        player.currentTime = TimeInterval(sender.value)
    }
    
    // volume controll
    @IBAction func changedVolumeSlider(sender: UISlider) {
        if player == nil { return }
        player.volume = sender.value
        volumeLabel.text = "\(player.volume)"
    }
    
}

extension AudioPlayTestVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NSLog("audioPlayerDidFinishPlaying \(flag)")
        playTimeLabel.text = makeTimeText(0)
        playerSlider.value = 0
        progressTimer.invalidate()
    }
}
