//
//  StartStopButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/6/21.
//

import SwiftUI

struct StartStopButton: View {
    @EnvironmentObject var timerManager: TimerManager
    @State var showingAlert = false
    
    var body: some View {
        RoundedButton(action: timerManager.mode == .running
                              ? {showingAlert.toggle()}
                              : {self.timerManager.start()},
                      buttonText: timerManager.mode == .running ? "stop" : "start",
                      width: UIScreen.main.bounds.width / 2)
            .alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Are you sure you want to stop the timer?"),
                    primaryButton: .destructive(Text("Yes")) {
                        self.timerManager.stop()
                    },
                    secondaryButton: .cancel()
                )
            }
    }
}

struct StartStopButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton()
            .environmentObject(TimerManager())
    }
}
