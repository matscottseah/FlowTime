//
//  InterruptionBadge.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/7/21.
//

import SwiftUI

struct InterruptionBadge: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        BadgeWithAction(action: { self.flowTimeManager.subtractInterruption() },
                        badgeText: String(self.flowTimeManager.interruptionCount),
                        width: 30,
                        height: 20)
    }
}

struct InterruptionBadge_Previews: PreviewProvider {
    static var previews: some View {
        InterruptionBadge()
            .environmentObject(FlowTimeManager())
    }
}
