//
//  TimerView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            Text(String(format: "%02d:%02d:%02d", timerManager.hours, timerManager.minutes, timerManager.seconds))
                .font(.largeTitle)
                .padding()
            HStack {
                if timerManager.mode == .stopped {
                    Button(action: {self.timerManager.start()}) {
                        Image(systemName: "play.fill")
                    }
                }
                if timerManager.mode == .running {
                    Button(action: {self.timerManager.stop()}) {
                        Image(systemName: "stop.fill")
                    }
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
