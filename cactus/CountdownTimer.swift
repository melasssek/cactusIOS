//
//  CountdownTimer.swift
//  cactus
//
//  Created by М on 8/3/20.
//  Copyright © 2020 Мelissa Seksenbayeva. All rights reserved.
//

import Foundation

class CountdownTimer {
    var timer: Timer?
    var secondsLeft: Int
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    let secondsLeftChangedHandler: (Int) -> Void
    
    init(durationInSeconds: Int, secondsLeftChangedHandler: @escaping (Int) -> Void) {
        secondsLeft = durationInSeconds
        self.secondsLeftChangedHandler = secondsLeftChangedHandler
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsLeft -= 1
            self.secondsLeftChangedHandler(self.secondsLeft)
            
            if self.secondsLeft == 0 {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
