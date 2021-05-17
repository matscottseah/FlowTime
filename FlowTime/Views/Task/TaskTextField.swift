//
//  TaskTextField.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/9/21.
//

import SwiftUI

struct TaskTextField: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        VStack {
            TextField("what are you focusing on?", text: $flowTimeManager.taskName)
                .multilineTextAlignment(.leading)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color("Gray"))
        }
        .frame(width: UIScreen.main.bounds.width / 1.35)
    }
}

struct TaskTextField_Previews: PreviewProvider {
    static var previews: some View {
        TaskTextField()
            .environmentObject(FlowTimeManager())
    }
}
