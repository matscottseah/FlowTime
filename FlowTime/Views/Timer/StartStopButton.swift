//
//  StartStopButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/6/21.
//

import SwiftUI

struct StartStopButton: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        RoundedButton(action: timerManager.mode == .running ? {self.timerManager.stop()} : {self.timerManager.start()},
                      buttonText: timerManager.mode == .running ? "stop" : "start",
                      width: UIScreen.main.bounds.width / 2)
    }
}

struct StartStopButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton()
            .environmentObject(TimerManager())
    }
}
