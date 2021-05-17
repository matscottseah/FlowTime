//
//  TodayViewitem.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/16/21.
//

import SwiftUI

struct TodayViewitem: View {
//    @EnvironmentObject var flowTimeManager: FlowTimeManager
    var mainText: String
    var subText: String
    
    var body: some View {
        VStack {
            Text(mainText)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color("Gray"))
                .padding()
                .frame(width: 70, height: 70)
                .overlay(Circle().stroke(Color("Gray"), lineWidth: 6))
                
            Text(subText)
                .font(.system(size: 12))
                .foregroundColor(Color("Gray"))
        }
        .frame(width: 75)
        .padding()
    }
}

struct TodayViewitem_Previews: PreviewProvider {
    static var previews: some View {
        TodayViewitem(mainText: "53:00", subText: "interruptions")
//            .environmentObject(FlowTimeManager())
    }
}
