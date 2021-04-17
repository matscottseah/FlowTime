//
//  TimerText.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/13/21.
//

import SwiftUI

enum fontSize {
    case large
    case small
}

struct TimerText: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    var timerSize: fontSize
    
    var body: some View {
        Text(timeStringFromDateComponents(dateComponents: DateComponents(hour: flowTimeManager.hours, minute: flowTimeManager.minutes, second: flowTimeManager.seconds), withSeconds: true))
            .font(timerSize == .large ? .system(size: 40, weight: .regular, design: .default) : .title)
            .foregroundColor(Color("Gray"))
    }
}

struct TimerText_Previews: PreviewProvider {
    static var previews: some View {
        TimerText(timerSize: .large)
            .environmentObject(FlowTimeManager())
    }
}
