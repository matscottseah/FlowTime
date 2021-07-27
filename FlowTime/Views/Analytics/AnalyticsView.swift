//
//  AnalyticsView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

enum Granularity {
    case day
    case week
    case month
    case overview
}

struct AnalyticsView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    @State private var granularity: Granularity = .week
    
    var body: some View {
        VStack() {
            SummaryView(granularity: $granularity)
                .padding(.bottom)
            
            DetailView(granularity: $granularity)
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
            .environmentObject(FlowTimeManager())
    }
}
