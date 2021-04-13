//
//  ContentView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    @State var selectedTab: Int = 0
    
    var tabButtons = ["timer", "chart.pie"]
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedTab {
                case 0:
                    TimerView()
                case 1:
                    AnalyticsView()
                default:
                    Text("Default")
                }
            }
            
            Spacer()
            
            HStack {
                ForEach(0..<tabButtons.count) { index in
                    Button(action: {selectedTab = index}, label: {
                        Spacer()
                        Image(systemName: tabButtons[index])
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(selectedTab == index ? Color("Gray") : Color(UIColor.systemGray3))
                        Spacer()
                    })
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(FlowTimeManager())
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(FlowTimeManager())
        }
    }
}
