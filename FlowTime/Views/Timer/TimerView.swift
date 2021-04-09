//
//  TimerView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerManager: TimerManager
    @State private var task: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            TextField("what are you focusing on?", text: $task)
                .multilineTextAlignment(.center)
            
            Text(String(format: "%02d:%02d:%02d", timerManager.hours, timerManager.minutes, timerManager.seconds))
                .font(.system(size: 40, weight: .regular, design: .default))
                .foregroundColor(Color("Gray"))
            
            Spacer()
            
            InterruptionBadge()
                .offset(x: 75)
                .padding(.bottom, -25)
                .disabled(timerManager.interruptionCount <= 0)
            
            InterruptionButton()
                .disabled(timerManager.mode == .stopped)
            
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
                .environmentObject(TimerManager())
        }
    }
}
