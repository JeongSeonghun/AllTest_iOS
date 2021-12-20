//
//  SliderTestVC.swift
//  AllTest
//  
//  Created by jsh on 2021/09/28
//  custom header comment

import Foundation
import UIKit

/**
 slider 테스트
 */
class SliderTestVC: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderInt: UISlider!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueIntLabel: UILabel!
    
    override func viewDidLoad() {
        slider.minimumValue = 0 // defualt: 0
        slider.maximumValue = 10 // default: 1.0
        
        valueLabel.text = String(slider.value)
        
        
        sliderInt.minimumValue = 0 // defualt: 0
        sliderInt.maximumValue = 10 // default: 1.0
        sliderInt.value = 5
        
        sliderInt.minimumTrackTintColor = .black
        sliderInt.maximumTrackTintColor = .cyan
        sliderInt.thumbTintColor = .green
//        sliderInt.minimumValueImage = UIImage(named: "")
//        sliderInt.maximumValueImage = UIImage(named: "")
//        sliderInt.setThumbImage(UIImage(named: ""), for: .normal)
        
        valueIntLabel.text = String(Int(sliderInt.value))
    }
    
    @IBAction func changeValue(sender: UISlider) {
        valueLabel.text = String(sender.value)
    }
    
    @IBAction func changeValueInt(sender: UISlider) {
        let value = Int(sender.value)
        valueIntLabel.text = String(value)
        
        sliderInt.value = Float(value)
    }
}
