//
//  InterruptionButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/7/21.
//

import SwiftUI

struct InterruptionButton: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        
        Button(action:
                { self.timerManager.addInterruption() }
        ) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                .font(Font.title.weight(.ultraLight))
                .foregroundColor(Color("Gray"))
        }
    }
}

struct InterruptionButton_Previews: PreviewProvider {
    static var previews: some View {
        InterruptionButton()
            .environmentObject(TimerManager())
    }
}
