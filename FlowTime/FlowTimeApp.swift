//
//  FlowTimeApp.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

@main
struct FlowTimeApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var flowTimeManager = FlowTimeManager()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(flowTimeManager)
        }
        .onChange(of: scenePhase) { _ in
            var _ = persistenceController.save()
        }
    }
}
