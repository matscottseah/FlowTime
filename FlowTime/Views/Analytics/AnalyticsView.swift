//
//  AnalyticsView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct AnalyticsView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    var flows = FlowController.getAllFlows()
    
    var body: some View {
        VStack {
            if flowTimeManager.mode == .running {
                TimerText(timerSize: .small)
            }
            
            TodayView()
                .padding()
            
            List {
                ForEach(flows) { (flow: Flow) in
                    Text(flow.task ?? "unknown")
                }
            }
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .environmentObject(FlowTimeManager())
    }
}
