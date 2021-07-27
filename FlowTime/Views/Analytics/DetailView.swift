//
//  DetailView.swift
//  FlowTime
//
//  Created by Matthew Seah on 6/6/21.
//

import SwiftUI

func monthFrom(offset: Int) -> String {
    let date = Calendar.current.date(byAdding: .month, value: -1 * offset, to: Date().startOfMonth, wrappingComponents: false)
    return date?.month() ?? ""
}

func weekFrom(offset: Int) -> String {
    let dateFrom = Calendar.current.date(byAdding: .day, value: -7 * offset, to: Date().startOfWeek, wrappingComponents: false)
    let dateTo = dateFrom?.endOfWeek
    return dateFrom != nil && dateTo != nil
           ? dateFrom!.weekOf() + " - " + dateTo!.weekOf()
           : ""
}

func monthLegend(offset: Int) -> [String] {
    var legend: [String] = []
    var date = Calendar.current.date(byAdding: .month, value: -1 * offset, to: Date().startOfMonth, wrappingComponents: false)
    let endDate = date!.endOfMonth
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M/dd"
    
    while date! < endDate {
        legend.append(dateFormatter.string(from: date!))
        date = Calendar.current.date(byAdding: .day, value: 7, to: date!, wrappingComponents: false)
    }
    
    return legend
}

struct DetailView: View {
    @Binding var granularity: Granularity
    @State private var weekOfFlows: Granularity = .week
    @State private var offset: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $granularity.onChange(resetOffset), label: Text("Granularity")) {
                Text("Week").tag(Granularity.week)
                Text("Month").tag(Granularity.month)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            VStack(spacing: -15) {
                HStack(spacing: -10) {
                    StylizedButton(action: {offset += 1}, systemImage: "arrow.left", text: nil, width: 20, height: nil, fill: false, style: .noBorder)
                    Spacer()
                    Text(granularity == .week ? weekFrom(offset: offset) : monthFrom(offset: offset))
                        .font(.title3)
                    Spacer()
                    StylizedButton(action: {offset -= 1}, systemImage: "arrow.right", text: nil, width: 20, height: nil, fill: false, style: .noBorder)
                        .disabled(offset <= 0)
                    StylizedButton(action: {offset = 0}, systemImage: "calendar.badge.clock", text: nil, width: 20, height: nil, fill: false, style: .noBorder)
                }
                
                if (granularity == .week) {
                    StackedBarChartView(flows: FlowController.getFlowTimesForWeekWith(offset: offset).map{$0.toHours},
                                        rests: RestController.getRestTimesForWeekWith(offset: offset).map{$0.toHours},
                                        legend: ["S", "M", "T", "W", "T", "F", "S"],
                                        itemCount: 7,
                                        yLabelsCount: 7,
                                        yLinesCount: 14,
                                        maxY: 24.0,
                                        chartTitle: "",
                                        chartSubtitle: "")
                } else if (granularity == .month) {
                    StackedBarChartView(flows: FlowController.getFlowTimesForMonthWith(offset: offset).map{$0.toHours},
                                        rests: RestController.getRestTimesForMonthWith(offset: offset).map{$0.toHours},
                                        legend: monthLegend(offset: offset),
                                        itemCount: 5,
                                        yLabelsCount: 7,
                                        yLinesCount: 14,
                                        maxY: 168,
                                        chartTitle: "",
                                        chartSubtitle: "")
                } else {
                    EmptyView()
                }
            }
        }
        .padding()
        .frame(width: 340, height: 450)
        .background(Color("White"))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func resetOffset(_ granularity: Granularity) {
        offset = 0
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(granularity: .constant(.month))
    }
}
