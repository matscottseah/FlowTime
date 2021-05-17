//
//  FlowView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

struct FlowView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(flowTimeManager.taskName)
                        .font(.title)
                    Text(flowTimeManager.mode == .resting
                            ? "Rest \(flowTimeManager.restCount)"
                            : "Flow \(flowTimeManager.flowCount)")
                        .font(.body)
                        .foregroundColor(Color("Gray"))
                        .opacity(0.6)
                }
                .padding([.top, .leading])
                Spacer()
            }
            
            Spacer()
            
            ZStack {
                if (flowTimeManager.mode == .resting) {
                    StopWatchView()
                } else {
                    TimerView()
                }
                
                FlowButtons()
                    .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                    .offset(y: 235)
            }
            
            Spacer()
            Spacer()
        }
        
    }
}

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlowView()
                .environmentObject(FlowTimeManager())
        }
    }
}
