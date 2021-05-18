//
//  StopWatchView.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/15/21.
//

import SwiftUI

struct StopWatchView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        ZStack {
            //  Minutes
            ClockView(majorTickCount: 60,
                      subdivisionCount: 4,
                      clockHandAngle: Angle.degrees(Double(flowTimeManager.totalTime) * 360/3600),
                      tickHeight: 15,
                      labeledTickMultiple: 5,
                      maxTickLabel: 0,
                      font: .title2,
                      width: UIScreen.main.bounds.width)
            
            //  Seconds
            ClockView(majorTickCount: 12,
                      subdivisionCount: 5,
                      clockHandAngle: Angle.degrees(Double(flowTimeManager.totalTime) * 360/60),
                      tickHeight: 10,
                      labeledTickMultiple: 3,
                      maxTickLabel: 0,
                      font: .caption,
                      width: UIScreen.main.bounds.width/3.5)
                .offset(y: -70)
            
            Text(flowTimeManager.totalTime.formatted)
                .font(.title2.monospacedDigit())
                .offset(y: 80)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
            .environmentObject(FlowTimeManager())
    }
}
