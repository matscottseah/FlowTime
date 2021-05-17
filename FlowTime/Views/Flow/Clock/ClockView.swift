//
//  ClockView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/30/21.
//

import SwiftUI
import Combine

struct ClockView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var majorTickCount: Int
    var subdivisionCount: Int
    var clockHandAngle: Angle
    var tickHeight: CGFloat
    var labeledTickMultiple: Int
    var maxTickLabel: Int
    var font: Font
    var width: CGFloat
    
    var body: some View {
        ZStack {
            ClockHandView(clockHandAngle: clockHandAngle)
            ClockFaceView(majorTickCount: majorTickCount, subdivisionCount: subdivisionCount, tickHeight: tickHeight, labeledTickMultiple: labeledTickMultiple, maxTickLabel: maxTickLabel, font: font)
        }
        .frame(width: width, height: width, alignment: .center)
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView(majorTickCount: 60,
                  subdivisionCount: 4,
                  clockHandAngle: Angle.degrees(Double(10) * 360/60),
                  tickHeight: 15,
                  labeledTickMultiple: 5,
                  maxTickLabel: 60,
                  font: .title2,
                  width: UIScreen.main.bounds.width)
            .environmentObject(FlowTimeManager())
   }
}
