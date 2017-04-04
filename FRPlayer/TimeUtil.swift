//
//  TimeUtil.swift
//  FRPlayer
//
//  Created by John Gainfort Jr on 4/3/17.
//  Copyright © 2017 John Gainfort Jr. All rights reserved.
//

import Foundation

class TimeUtil {
    
    func formatSecondsToString(seconds: Double) -> String {
        let hr =  addLeadingZero(floor(seconds / 3600))
        let min = addLeadingZero(floor(seconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let sec = addLeadingZero(floor(seconds.truncatingRemainder(dividingBy: 60)))
        
        return hr != "00" ? "\(hr):\(min):\(sec)" : "\(min):\(sec)"
    }
    
    private func addLeadingZero(_ num: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        return formatter.string(from: NSNumber(value: num)) ?? "00"
    }
    
}
