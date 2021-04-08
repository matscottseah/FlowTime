//
//  TimerManager.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

enum timerMode {
    case running
    case stopped
}

class TimerManager: ObservableObject {
    
    @Published var mode: timerMode = .stopped
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    @Published var interruptionCount: Int = 0
    
    private var totalTimeInSeconds: Int = 0
    private var timer = Timer()
    
    func start() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.totalTimeInSeconds += 1
            self.seconds = Int(self.totalTimeInSeconds % 60)
            self.minutes = Int((self.totalTimeInSeconds / 60) % 60)
            self.hours = Int(self.totalTimeInSeconds / 3600)
        }
    }
    
    func stop() {
        mode = .stopped
        timer.invalidate()
        totalTimeInSeconds = 0
        seconds = 0
        minutes = 0
        hours = 0
        interruptionCount = 0
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
