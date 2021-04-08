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
        BadgeWithAction(action: { self.timerManager.subtractInterruption() },
                        badgeText: String(self.timerManager.interruptionCount),
                        width: 30,
                        height: 20)
    }
}

struct InterruptionBadge_Previews: PreviewProvider {
    static var previews: some View {
        InterruptionBadge()
            .environmentObject(TimerManager())
    }
}
