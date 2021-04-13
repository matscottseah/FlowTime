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
        TextField("what are you focusing on?",
                  text: $flowTimeManager.task)
            .multilineTextAlignment(.center)
    }
}

struct TaskTextField_Previews: PreviewProvider {
    static var previews: some View {
        TaskTextField()
    }
}
