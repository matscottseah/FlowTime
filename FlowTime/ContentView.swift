//
//  ContentView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AnalyticsView()
                .tabItem {
                    Label("Analytics", systemImage: "chart.pie")
                }
            
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            
            PlannerView()
                .tabItem {
                    Label("Planner", systemImage: "calendar.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
