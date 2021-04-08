//
//  InterruptionBadge.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/7/21.
//

import SwiftUI

struct InterruptionBadge: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        Button(action:
                { self.timerManager.subtractInterruption() }
        ) {
            Text(String(self.timerManager.interruptionCount))
                .font(.system(size: 20, weight: .semibold, design: .default))
                .frame(minWidth: 20, maxWidth: 40, minHeight: 20, maxHeight: 20)
                .padding()
                .foregroundColor(Color.white)
                .background(Color.red)
                .clipShape(Circle())
        }
    }
}

struct InterruptionBadge_Previews: PreviewProvider {
    static var previews: some View {
        InterruptionBadge()
            .environmentObject(TimerManager())
    }
}
