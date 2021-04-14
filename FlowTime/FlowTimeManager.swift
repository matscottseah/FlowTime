//
//  FlowTimeManager.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

enum timerMode {
    case running
    case stopped
}

class FlowTimeManager: ObservableObject {
    @Published var mode: timerMode = .stopped
    
    @Published var elapsedTime: Int = 0
    @Published var seconds: Int = 0
    @Published var minutes: Int = 0
    @Published var hours: Int = 0
    
    @Published var interruptionCount: Int32 = 0
    @Published var task: String = ""
    
    private var timer = Timer()
    private var flow: Flow?
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.elapsedTime += 1
            self.seconds = Int(self.elapsedTime % 60)
            self.minutes = Int((self.elapsedTime / 60) % 60)
            self.hours = Int(self.elapsedTime / 3600)
        }
        
        flow = FlowController.createFlow()
    }
    
    func stop() {
        mode = .stopped
        timer.invalidate()
        flow = FlowController.update(flow: flow!, stopTime: Date(), task: task, interruptionCount: interruptionCount)
        reset()
    }
    
    private func reset() {
        (elapsedTime, seconds, minutes, hours, interruptionCount, task) = (0, 0, 0, 0, 0, "")
    }
    
    func addInterruption() {
        if (mode == timerMode.running) {
            interruptionCount += 1
        }
    }
    
    func subtractInterruption() {
        if (interruptionCount > 0) {
            interruptionCount -= 1
        }
    }
}
