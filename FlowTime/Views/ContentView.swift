//
//  ContentView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerManager: TimerManager
    
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("timer", systemImage: "timer")
                }
            
            AnalyticsView()
                .tabItem {
                    Label("analytics", systemImage: "chart.pie")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TimerManager())
    }
}
