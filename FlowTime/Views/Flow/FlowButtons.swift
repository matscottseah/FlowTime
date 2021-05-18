//
//  FlowButtons.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/7/21.
//

import SwiftUI

enum Mode {
    case flow
    case paused
    case rest
}

struct FlowButtons: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        switch flowTimeManager.mode {
        case .flowing:
            VStack {
                HStack {
                    Spacer()
                    StylizedButton(action: {flowTimeManager.pauseFlow()}, systemImage: "pause.fill", text: nil, width: 30, height: nil, fill: false, style: .circle, isActive: true)
                        .padding([.leading, .trailing])
                }
                Spacer()
            }
        case .paused:
            VStack {
                HStack {
                    StylizedButton(action: {flowTimeManager.startRest()}, systemImage: "moon.fill", text: nil, width: 30, height: nil, fill: false, style: .circle, isActive: true)
                        .padding([.leading, .trailing])
                    Spacer()
                    StylizedButton(action: {flowTimeManager.startFlow()}, systemImage: "play.fill", text: nil, width: 30, height: nil, fill: false, style: .circle, isActive: true)
                        .padding([.leading, .trailing])
                }
                Spacer()
                StylizedButton(action: {flowTimeManager.stopTask()}, systemImage: nil, text: "Complete Task", width: UIScreen.main.bounds.width / 2, height: nil, fill: true, style: .capsule, isActive: true)
            }
        case .resting:
            VStack {
                HStack {
                    Spacer()
                    StylizedButton(action: {flowTimeManager.startFlow()}, systemImage: "forward.fill", text: nil, width: 30, height: nil, fill: false, style: .circle, isActive: true)
                        .padding([.leading, .trailing])
                }
                Spacer()
                StylizedButton(action: {flowTimeManager.stopTask()}, systemImage: nil, text: "Complete Task", width: UIScreen.main.bounds.width / 2, height: nil, fill: true, style: .capsule, isActive: true)
            }
        default:
            EmptyView()
        }
    }
}

struct FlowButtons_Previews: PreviewProvider {
    static var previews: some View {
        FlowButtons()
            .environmentObject(FlowTimeManager())
    }
}
