//
//  InterruptionButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/8/21.
//

import SwiftUI

struct InterruptionButton: View {
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    
    var body: some View {
        PlusButton(action: {flowTimeManager.addInterruption()},
                   width: UIScreen.main.bounds.width / 2,
                   height: UIScreen.main.bounds.width / 2)
    }
}

struct InterruptionButton_Previews: PreviewProvider {
    static var previews: some View {
        InterruptionButton()
    }
}
