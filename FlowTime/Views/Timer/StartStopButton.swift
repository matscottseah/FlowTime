//
//  StartStopButton.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/6/21.
//

import SwiftUI

struct StartStopButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var flowTimeManager: FlowTimeManager
    @State var showingAlert = false
    @State var flow: Flow?
    
    var body: some View {
        RoundedButton(action: flowTimeManager.mode == .running
                              ? { showingAlert.toggle() }
                              : { startTimer() },
                      buttonText: flowTimeManager.mode == .running ? "stop" : "start",
                      width: UIScreen.main.bounds.width / 2)
            .alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Are you sure you want to stop the timer?"),
                    primaryButton: .destructive(Text("Yes")) { stopTimer() },
                    secondaryButton: .cancel()
                )
            }
    }
    
    private func startTimer() {
        flow = Flow(context: viewContext)
        flow!.id = UUID()
        flow!.startTime = Date()
        
        self.flowTimeManager.start()
    }
    
    private func stopTimer() {
        flow!.stopTime = Date()
        flow!.task = flowTimeManager.task
        flow!.interruptionCount = Int64(flowTimeManager.interruptionCount)
        flow!.elapsedTime = Int64(flowTimeManager.elapsedTime)
        
        PersistenceController.shared.save()
        
        self.flowTimeManager.stop()
    }
}

struct StartStopButton_Previews: PreviewProvider {
    static var previews: some View {
        StartStopButton()
            .environmentObject(FlowTimeManager())
    }
}
