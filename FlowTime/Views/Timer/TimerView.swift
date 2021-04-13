//
//  TimerView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        VStack {
            Spacer()
            TaskTextField()
            
            Text(String(format: "%02d:%02d:%02d", flowTimeManager.hours, flowTimeManager.minutes, flowTimeManager.seconds))
                .font(.system(size: 40, weight: .regular, design: .default))
                .foregroundColor(Color("Gray"))
            
            Spacer()
            
            InterruptionBadge()
                .offset(x: 75)
                .padding(.bottom, -25)
                .disabled(flowTimeManager.interruptionCount <= 0)
            
            InterruptionButton()
                .disabled(flowTimeManager.mode == .stopped)
            
            Spacer()
            
            StartStopButton()
            
            Spacer()
        }
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerView()
                .environmentObject(FlowTimeManager())
        }
    }
}
