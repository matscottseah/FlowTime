//
//  Helper.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/14/21.
//

import Foundation

func dateComponentsFromTimeInterval(timeInterval: TimeInterval) -> DateComponents {
    let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    let minutes = Int((timeInterval / 60).truncatingRemainder(dividingBy: 60))
    let hours = Int(timeInterval / 3600)
    
    return DateComponents(hour: hours, minute: minutes, second: seconds)
}

func timeStringFromDateComponents(dateComponents: DateComponents) -> String {
    return String(format: "%02d:%02d:%02d", dateComponents.hour!, dateComponents.minute!, dateComponents.second!)
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}