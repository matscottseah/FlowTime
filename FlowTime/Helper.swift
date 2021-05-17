//
//  Helper.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/14/21.
//

import Foundation
import SwiftUI

func dateComponentsFromTimeInterval(timeInterval: TimeInterval) -> DateComponents {
    let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    let minutes = Int((timeInterval / 60).truncatingRemainder(dividingBy: 60))
    let hours = Int(timeInterval / 3600)
    
    return DateComponents(hour: hours, minute: minutes, second: seconds)
}

func timeStringFromDateComponents(dateComponents: DateComponents, withSeconds: Bool) -> String {
    if (withSeconds) {
        return String(format: "%02d:%02d:%02d", dateComponents.hour!, dateComponents.minute!, dateComponents.second!)
    } else {
        return String(format: "%02d:%02d", dateComponents.hour!, dateComponents.minute!)
    }
}
    
func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
}

let formatter: DateComponentsFormatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.hour, .minute, .second]
    f.zeroFormattingBehavior = .pad
    return f
}()

extension TimeInterval {
    var formatted: String {
        return formatter.string(from: self)!
    }
}
