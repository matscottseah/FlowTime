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
            TextField("what are you focusing on?", text: $task)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(String(format: "%02d:%02d:%02d", timerManager.hours, timerManager.minutes, timerManager.seconds))
                .font(.system(size: 40, weight: .regular, design: .default))
                .foregroundColor(Color("Gray"))
                .padding(.bottom, 50)
            
            InterruptionBadge()
                .offset(x: 75)
                .padding(.bottom, -25)
            
            InterruptionButton()
                .padding(.bottom, 75)
            
            StartStopButton()
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimerManager())
    }
}
