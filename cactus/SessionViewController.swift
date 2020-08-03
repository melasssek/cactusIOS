//
//  ViewController.swift
//  cactus
//
//  Created by М on 7/28/20.
//  Copyright © 2020 Мelissa Seksenbayeva. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, SessionManagerDelegate {
    @IBOutlet var cactusImageView: UIImageView!
    
    @IBOutlet var plantButton: UIButton!
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var giveUpButton: UIButton!
    
    lazy var sessionManager = SessionManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cactusImageView.layer.cornerRadius = cactusImageView.frame.width / 2
        cactusImageView.layer.masksToBounds = true
        
        plantButton.layer.cornerRadius = 14
        plantButton.layer.masksToBounds = true
        
        giveUpButton.layer.cornerRadius = 14
        giveUpButton.layer.masksToBounds = true
        giveUpButton.layer.borderWidth = 1
        giveUpButton.layer.borderColor = UIColor(named: "darkGrey")?.cgColor
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func didTapPlantButton() {
        let selectedPickerRow = pickerView.selectedRow(inComponent: 0)
        let selectedDuration = durations[selectedPickerRow]
        
        let session = Session(durationInSeconds: selectedDuration)
        sessionManager.startSession(session: session)
    }
    
    @IBAction func didTapGiveUpButton() {
        sessionManager.stopSession()
    }
    
    let durations = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(durations[row]) mins"
    }
    
    // SessionManagerDelegate
    
    func sessionDidStart(session: Session) {
        showTimeLeft(secondsLeft: session.durationInSeconds)
        
        pickerView.isHidden = true
        plantButton.isHidden = true
        countdownLabel.isHidden = false
        giveUpButton.isHidden = false
    }
    
    func sessionTimeLeftChanged(secondsLeft: Int) {
        showTimeLeft(secondsLeft: secondsLeft)
    }
    
    func showTimeLeft(secondsLeft: Int) {
        countdownLabel.text = String(format: "%02d:%02d", secondsLeft / 60, secondsLeft % 60)
    }
    
    func sessionDidEnd(session: Session) {
        
        performSegue(withIdentifier: "showBreak", sender: nil)
        
        pickerView.isHidden = false
        plantButton.isHidden = false
        countdownLabel.isHidden = true
        giveUpButton.isHidden = true
    }
    
    func sessionDidCancel() {
        pickerView.isHidden = false
        plantButton.isHidden = false
        countdownLabel.isHidden = true
        giveUpButton.isHidden = true
    }
}
