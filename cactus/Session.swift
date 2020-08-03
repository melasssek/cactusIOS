//
//  Session.swift
//  cactus
//
//  Created by М on 8/3/20.
//  Copyright © 2020 Мelissa Seksenbayeva. All rights reserved.
//

import Foundation

class Session {
    let durationInSeconds: Int
    
    init(durationInSeconds: Int) {
        self.durationInSeconds = durationInSeconds
    }
    
    var coinsCount: Int {
        if durationInSeconds <= 30 * 60 {
            return 3
        } else if durationInSeconds <= 60 * 60 {
            return 6
        } else {
            return 9
        }
    }
}

