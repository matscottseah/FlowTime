//
//  TaskView.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/29/21.
//

import SwiftUI

struct TaskView: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        VStack() {
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("FLOW")
                    Text("TIME")
                }
                .font(.system(size: 50, weight: .heavy, design: .default))
                .padding(.leading, 40)
                Spacer()
            }
            
            Spacer()
            
            TaskTextField()
                .padding(.bottom)
            
            StylizedButton(action: {flowTimeManager.startTask()}, systemImage: nil, text: "start", width: UIScreen.main.bounds.width/2, height: nil, fill: true, style: .capsule)
                .disabled(flowTimeManager.taskName.isEmpty)
        }
        .padding(.bottom, 100)
        .navigationBarHidden(true)
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
            .environmentObject(FlowTimeManager())
    }
}
