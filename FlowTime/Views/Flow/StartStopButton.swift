////
////  StartStopButton.swift
////  FlowTime
////
////  Created by Matthew Seah on 4/6/21.
////
//
//import SwiftUI
//
//struct StartStopButton: View {
////    @EnvironmentObject var flowTimeManager: FlowTimeManager
//    @State var showingAlert = false
//    @State var mode
//
//    var body: some View {
//        RoundedButton(action: flowTimeManager.mode == .running
//                              ? { showingAlert.toggle() }
//                              : { self.flowTimeManager.start() },
//                      buttonText: flowTimeManager.mode == .running ? "stop" : "start",
//                      width: UIScreen.main.bounds.width / 2)
//            .alert(isPresented:$showingAlert) {
//                Alert(
//                    title: Text("Are you sure you want to stop the timer?"),
//                    primaryButton: .destructive(Text("Yes")) { self.flowTimeManager.stop() },
//                    secondaryButton: .cancel()
//                )
//            }
//    }
//}
//
//struct StartStopButton_Previews: PreviewProvider {
//    static var previews: some View {
//        StartStopButton()
////            .environmentObject(FlowTimeManager())
//    }
//}
