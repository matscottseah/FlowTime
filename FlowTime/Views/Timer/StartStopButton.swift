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
        Button(action:
            timerManager.mode == .running
            ? {self.timerManager.stop()}
            : {self.timerManager.start()}
        ) {
            (timerManager.mode == .running
            ? Text("stop")
            : Text("start"))
                .foregroundColor(Color("White"))
                .fontWeight(.bold)
                .font(.body)
                .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width / 2)
                .padding()
                .background(Color("UIColor.darkGray"))
                .cornerRadius(40)
        }
    }
}

struct StartStopButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton()
            .environmentObject(TimerManager())
    }
}
