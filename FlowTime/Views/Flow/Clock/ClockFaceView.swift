//
//  ClockFaceView.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/3/21.
//

import SwiftUI

struct ClockFaceView: View {
    var majorTickCount: Int
    var subdivisionCount: Int
    var tickHeight: CGFloat
    var labeledTickMultiple: Int
    var maxTickLabel: Int
    var font: Font = .title2
    var totalTicks: Int { majorTickCount * subdivisionCount }
    
    var body: some View {
        ZStack {
            ForEach(0..<totalTicks) { tick in
                let isMajorTick = tick % subdivisionCount == 0
                let isLabeledTick = tick % (subdivisionCount * labeledTickMultiple) == 0
                VStack {
                    Rectangle()
                        .fill(Color("Gray"))
                        .opacity(isLabeledTick ? 1 : 0.3)
                        .frame(width: 2, height: isMajorTick ? tickHeight : tickHeight/2)
                    if (isLabeledTick) {
                        Text("\(tickLabel(tick: tick))")
                            .rotationEffect(Angle.degrees(-Double(tick)/Double(totalTicks) * 360))
                            .font(font)
                            .offset(y: -5)
                    }
                    Spacer()
                }
                    .rotationEffect(Angle.degrees(Double(tick)/Double(totalTicks) * 360))
            }
        }
        .padding()
        
    }
    
    private func tickLabel(tick: Int) -> Int {
        if (tick == 0) {
            return maxTickLabel
        } else if (majorTickCount * subdivisionCount == maxTickLabel) {
            return tick
        } else if (majorTickCount == 60) {
            return tick / subdivisionCount
        } else if (maxTickLabel == 0) {
            return tick
        } else {
            return tick / subdivisionCount
        }
    }
}

struct ClockFaceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //  Seconds
            ClockFaceView(majorTickCount: 60, subdivisionCount: 4, tickHeight: 15, labeledTickMultiple: 5, maxTickLabel: 0)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
            
            // Hourse
            ClockFaceView(majorTickCount: 4, subdivisionCount: 6, tickHeight: 15, labeledTickMultiple: 1, maxTickLabel: 24)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
            
            // Minutes
            ClockFaceView(majorTickCount: 12, subdivisionCount: 5, tickHeight: 15, labeledTickMultiple: 3, maxTickLabel: 0)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
        }
    }
}
