//
//  SummaryView.swift
//  FlowTime
//
//  Created by Matthew Seah on 6/6/21.
//

import SwiftUI

struct SummaryViewItem: View {
    var icon: Image
    var iconColor: Color
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack(alignment: .top) {
            icon
                .font(.title)
                .foregroundColor(iconColor)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                Text(subtitle)
                    .font(.caption)
            }
        }
    }
}

struct SummaryView: View {
    @Binding var granularity: Granularity
    var todaysFlowTime = FlowController.getTotalFlowTimeBy(date: Date())
    var todaysRestTime = RestController.getTotalRestTimeBy(date: Date())
    var todaysTasks = TaskController.getTotalTasksBy(date: Date())
    
    let columns = [
        GridItem(.fixed(130), alignment: .leading),
        GridItem(.fixed(130))
    ]
    
    var body: some View {
        VStack() {
            Spacer()
            
            HStack {
                Text("Today")
                    .font(.title).bold()
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer()
            
            LazyVGrid(columns: columns, spacing: 30) {
                SummaryViewItem(icon: Image(systemName: "stopwatch"),
                                iconColor: .blue,
                                title: todaysFlowTime.formattedHM,
                                subtitle: "Flow Time")
                SummaryViewItem(icon: Image(systemName: "powersleep"),
                                iconColor: .yellow,
                                title: todaysRestTime.formattedHM,
                                subtitle: "Rest Time")
                SummaryViewItem(icon: Image(systemName: "checkmark.circle"),
                                iconColor: .green,
                                title: String(todaysTasks),
                                subtitle: "Tasks Completed")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(width: 340, height: 240)
        .background(Color("White"))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct SummaryView_Previews: PreviewProvider {
    @State private var granularity: Granularity = .day
    
    static var previews: some View {
        SummaryView(granularity: .constant(.day))
    }
}
