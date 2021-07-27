//
//  TimerView.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/15/21.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        ZStack {
            //  Seconds
            ClockView(majorTickCount: 60,
                      subdivisionCount: 4,
                      clockHandAngle: Angle.degrees(Double(flowTimeManager.totalTime) * 360/60),
                      tickHeight: 15,
                      labeledTickMultiple: 5,
                      maxTickLabel: 60,
                      font: .title2,
                      width: UIScreen.main.bounds.width)
            
            //  Hours
            ClockView(majorTickCount: 12,
                      subdivisionCount: 5,
                      clockHandAngle: Angle.degrees(Double(flowTimeManager.totalTime) * 360/43200),
                      tickHeight: 10,
                      labeledTickMultiple: 3,
                      maxTickLabel: 12,
                      font: .caption,
                      width: UIScreen.main.bounds.width/3.5)
                .offset(x: -70)
            
            //  Minutes
            ClockView(majorTickCount: 12,
                      subdivisionCount: 5,
                      clockHandAngle: Angle.degrees(Double(flowTimeManager.totalTime) * 360/3600),
                      tickHeight: 10,
                      labeledTickMultiple: 3,
                      maxTickLabel: 60,
                      font: .caption,
                      width: UIScreen.main.bounds.width/3.5)
                .offset(x: 70)
            
            Text(flowTimeManager.totalTime.formattedHMS)
                .font(.title2.monospacedDigit())
                .offset(y: 80)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(FlowTimeManager())
    }
}
