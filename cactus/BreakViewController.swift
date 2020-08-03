//
//  BreakViewController.swift
//  cactus
//
//  Created by М on 8/3/20.
//  Copyright © 2020 Мelissa Seksenbayeva. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, SessionManagerDelegate {
    
    @IBOutlet var cactusImageView: UIImageView!
    @IBOutlet var takeABreakButton: UIButton!
    @IBOutlet var pickerBreak: UIPickerView!
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var finishBreakButton: UIButton!
    @IBOutlet var breakEndLabel: UILabel!
    
    lazy var sessionBreakManager = SessionManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cactusImageView.layer.cornerRadius = cactusImageView.frame.width / 2
        cactusImageView.layer.masksToBounds = true
        
        takeABreakButton.layer.cornerRadius = 14
        takeABreakButton.layer.masksToBounds = true
        
        pickerBreak.delegate = self
        pickerBreak.dataSource = self
    }
    
    @IBAction func didTapCloseButton() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapTakeABreakButton() {
        print("start break")
        let selectedPickerRow = pickerBreak.selectedRow(inComponent: 0)
        let selectedDuration = durations[selectedPickerRow]
        
        
        let session = Session(durationInSeconds: selectedDuration)
        sessionBreakManager.startSession(session: session)
    }
    
        
    
    @IBAction func didTapFinishBreakButton() {
        sessionBreakManager.stopSession()
    }

    let durations = [5, 10, 15, 20, 25, 30]

    func numberOfComponents(in pickerBreak: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerBreak: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }

    func pickerView(_ pickerBreak: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(durations[row]) mins"
    }


    func sessionDidStart(session: Session) {
        showTimeLeft(secondsLeft: session.durationInSeconds)

        pickerBreak.isHidden = true
        takeABreakButton.isHidden = true
        breakEndLabel.isHidden = false
        countdownLabel.isHidden = false
        finishBreakButton.isHidden = false
    }

    func sessionTimeLeftChanged(secondsLeft: Int) {
        showTimeLeft(secondsLeft: secondsLeft)
    }

    func showTimeLeft(secondsLeft: Int) {
        countdownLabel.text = String(format: "%02d:%02d", secondsLeft / 60, secondsLeft % 60)
    }

    func sessionDidEnd(session: Session) {
        presentingViewController?.dismiss(animated: true, completion: nil)

        pickerBreak.isHidden = false
        takeABreakButton.isHidden = false
        breakEndLabel.isHidden = true
        countdownLabel.isHidden = true
        finishBreakButton.isHidden = true
    }

    func sessionDidCancel() {
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
        pickerBreak.isHidden = false
        takeABreakButton.isHidden = false
        breakEndLabel.isHidden = true
        countdownLabel.isHidden = true
        finishBreakButton.isHidden = true
    }
}

