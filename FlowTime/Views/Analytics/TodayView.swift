//
//  TodayView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/13/21.
//

import SwiftUI
import CoreData

struct TodayView: View {
    var todaysTotalFlows = FlowController.getTotalFlowsByDate(date: Date())
    var todaysTotalFlowTime = FlowController.getTotalFlowTimeByDate(date: Date())
    var todaysTotalinterruptions = FlowController.getTotalInterruptionsByDate(date: Date())
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(String(todaysTotalFlows))
                Text("flows")
            }
            
            Spacer()
            
            VStack {
                Text(timeStringFromDateComponents(dateComponents: todaysTotalFlowTime))
                Text("flow time")
            }
            
            Spacer()
            
            VStack {
                Text(String(todaysTotalinterruptions))
                Text("interruptions")
            }
            
            Spacer()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    
    static var previews: some View {
        TodayView()
    }
}
