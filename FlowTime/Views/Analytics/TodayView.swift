////
////  TodayView.swift
////  FlowTime
////
////  Created by Matthew Seah on 4/13/21.
////
//
//import SwiftUI
//import CoreData
//
//struct TodayView: View {
////    var todaysTotalFlows = FlowController.getTotalFlowsByDate(date: Date())
////    var todaysTotalFlowTime = FlowController.getTotalFlowTimeByDate(date: Date())
////    var todaysTotalinterruptions = FlowController.getTotalInterruptionsByDate(date: Date())
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("today")
//                .font(.title2)
//                .padding(EdgeInsets(top: 10, leading: 30, bottom: -5, trailing: 0))
//            
//            HStack {
//                Spacer()
//                
//                TodayViewitem(mainText: String(todaysTotalFlows), subText: "flows")
//                
//                Spacer()
//                
//                TodayViewitem(mainText: timeStringFromDateComponents(dateComponents: todaysTotalFlowTime, withSeconds: false), subText: "flow time")
//                
//                Spacer()
//                              
//                TodayViewitem(mainText: String(todaysTotalinterruptions), subText: "interruptions")
//                
//                Spacer()
//            }
//        }
//        .frame(width: .infinity)
//        .background(Color(UIColor.systemGray6))
//        .cornerRadius(20)
//    }
//}
//
//struct TodayView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        TodayView()
////            .environmentObject(FlowTimeManager())
//    }
//}
