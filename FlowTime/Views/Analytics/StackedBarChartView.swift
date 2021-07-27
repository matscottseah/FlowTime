//
//  StackedBarChartView.swift
//  FlowTime
//
//  Created by Matthew Seah on 6/11/21.
//

import SwiftUI
import SwiftUICharts

func validateData(flows: inout [Double], rests: inout [Double], legend: inout [String], itemCount: Int) {
    if (flows.count != itemCount) {
        flows = flows.count > itemCount
                ? Array(flows[0..<itemCount])
                : flows + Array(repeating: 0, count: itemCount - flows.count)
    }
    if (rests.count != itemCount) {
        rests = rests.count > itemCount
                ? Array(rests[0..<itemCount])
                : rests + Array(repeating: 0, count: itemCount - rests.count)
    }
    if (legend.count != itemCount) {
        legend = legend.count > itemCount
                ? Array(legend[0..<itemCount])
                : legend + Array(repeating: "", count: itemCount - legend.count)
    }
}

func style(yLabelsCount: Int, yLinesCount: Int, maxY: Double) -> (BarStyle, BarChartStyle) {
    let barStyle = BarStyle(barWidth: CGFloat(0.5), cornerRadius: CornerRadius(top: CGFloat(5), bottom: CGFloat(5)), colourFrom: .dataPoints)

    let yGridStyle  = GridStyle(numberOfLines: yLinesCount,
                                lineColour   : Color(.lightGray).opacity(1),
                                lineWidth    : 0.5,
                                dash         : [1,0],
                                dashPhase    : 0)
    let xGridStyle  = GridStyle(numberOfLines: 8,
                                lineColour   : Color(.lightGray).opacity(1),
                                lineWidth    : 1,
                                dash         : [0],
                                dashPhase    : 0)

    let chartStyle = BarChartStyle( infoBoxPlacement    : .floating,
                                    infoBoxBorderColour : Color.primary,
                                    infoBoxBorderStyle  : StrokeStyle(lineWidth: 0.5),
                                    
                                    markerType          : .vertical(colour: Color.gray),
                                    
                                    xAxisGridStyle      : xGridStyle,
                                    xAxisLabelPosition  : .bottom,
                                    xAxisLabelColour    : Color.primary,
                                    xAxisLabelsFrom     : .dataPoint(rotation: .degrees(0)),
                                    
                                    yAxisGridStyle      : yGridStyle,
                                    yAxisLabelPosition  : .leading,
                                    yAxisLabelColour    : Color.primary,
                                    yAxisNumberOfLabels : yLabelsCount,
                                    
                                    baseline            : .zero,
                                    topLine             : .maximum(of: maxY),
                                    
                                    globalAnimation     : .easeOut(duration: 1))
    
    return (barStyle, chartStyle)
}

func chartData(flows: [Double], rests: [Double], legend: [String], itemCount: Int, yLabelsCount: Int, yLinesCount: Int, maxY: Double, chartTitle: String, chartSubtitle: String) -> StackedBarChartData {
    let flowGroupingData = GroupingData(title: "Flow Time", colour: ColourStyle(colour: Color("FlowBlue")))
    let restGroupingData = GroupingData(title: "Rest Time", colour: ColourStyle(colour: Color("ChartGray")))
    
    var dataSets: [StackedBarDataSet] = []
    for i in 0..<itemCount {
        let dataSet = StackedBarDataSet(dataPoints: [
                                            StackedBarDataPoint(value: Double(flows[i]), description: "Flow", date: nil, group: flowGroupingData),
                                            StackedBarDataPoint(value: Double(rests[i]), description: "Rest", date: nil, group: restGroupingData)],
                                        setTitle: legend[i])
        
        dataSets.append(dataSet)
    }
    
    let stackedDataSets = StackedBarDataSets(dataSets: dataSets)
    let metadata = ChartMetadata(title: chartTitle, subtitle: chartSubtitle)
    let (barStyle, chartStyle) = style(yLabelsCount: yLabelsCount, yLinesCount: yLinesCount, maxY: maxY)
    
    return StackedBarChartData(dataSets: stackedDataSets, groups: [flowGroupingData, restGroupingData], metadata: metadata, xAxisLabels: ["Period"], yAxisLabels: ["Hours"], barStyle: barStyle, chartStyle: chartStyle, noDataText: Text("No Data"))
}

struct StackedBarChartView: View {
    let barChartData: StackedBarChartData
    
    init(flows: [Double], rests: [Double], legend: [String], itemCount: Int, yLabelsCount: Int, yLinesCount: Int, maxY: Double, chartTitle: String, chartSubtitle: String) {
        var f = flows, r = rests, l = legend
        validateData(flows: &f, rests: &r, legend: &l, itemCount: itemCount)
        barChartData = chartData(flows: f, rests: r, legend: l, itemCount: itemCount, yLabelsCount: yLabelsCount, yLinesCount: yLinesCount, maxY: maxY, chartTitle: chartTitle, chartSubtitle: chartSubtitle)
    }
    
    var body: some View {
        StackedBarChart(chartData: barChartData)
            .touchOverlay(chartData: barChartData, specifier: "%.2f", unit: .suffix(of: "hours"))
            .xAxisGrid(chartData: barChartData)
            .yAxisGrid(chartData: barChartData)
            .xAxisLabels(chartData: barChartData)
            .yAxisLabels(chartData: barChartData)
            .infoBox(chartData: barChartData)
            .floatingInfoBox(chartData: barChartData)
            .headerBox(chartData: barChartData)
            .legends(chartData: barChartData, columns: [GridItem(.flexible()), GridItem(.flexible())])
            .id(barChartData.id)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static let flows = [1.5, 2.6, 7.4, 10.2, 5.4]
    static let rests = [0.5, 0.3, 1.4, 5.1, 6.3, 1.8, 3.0]
    static let legend = ["S", "M", "T", "W", "T", "F", "S"]
    
    static var previews: some View {
        StackedBarChartView(flows: flows, rests: rests, legend: legend, itemCount: 7, yLabelsCount: 6, yLinesCount: 13, maxY: 24.0, chartTitle: "Flow vs Rest Time", chartSubtitle: "For Week")
            .padding()
            .frame(width: 340, height: 400)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
