//
//  FlowManager.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/2/21.
//

import SwiftUI

enum TimerMode {
    case flowing
    case resting
    case paused
    case stopped
}

struct TaskData {
    var startTime: TimeInterval?
    var currentTime: TimeInterval = 0
    
    var totalTime: TimeInterval {
        return  currentTime - (startTime ?? currentTime)
    }
    
    mutating func start(at time: TimeInterval) {
        currentTime = time
        startTime = time
    }
    
    mutating func stop() {
        startTime = nil
    }
}

struct FlowData {
    var startTime: TimeInterval?
    var currentTime: TimeInterval = 0
    var additionalTime: TimeInterval = 0
    
    var totalTime: TimeInterval {
        guard let startTime = startTime else { return additionalTime }
        return additionalTime + currentTime - startTime
    }
    
    mutating func start(at time: TimeInterval) {
        currentTime = time
        startTime = time
    }
    
    mutating func stop() {
        additionalTime = totalTime
        startTime = nil
    }
}

struct RestData{
    var endTime: TimeInterval?
    var currentTime: TimeInterval = 0
    var countingDown: Bool = true
    
    var remainingTime: TimeInterval {
        return (endTime ?? currentTime) - currentTime
    }
    
    mutating func start(at time: TimeInterval, restTime: TimeInterval) {
        self.endTime = time + restTime
        currentTime = time
    }
    
    mutating func stop() {
        endTime = nil
    }
}

class FlowTimeManager: ObservableObject {
    @Published var mode: TimerMode = .stopped
    @Published var taskName: String = ""
    @Published var flowCount: Int = 0
    @Published var restCount: Int = 0
    @Published private var taskData: TaskData?
    @Published private var flowData: FlowData?
    @Published private var restData: RestData?
    
    private var timer: Timer?

    var totalTime: TimeInterval {
        switch mode {
        case .flowing,
             .paused,
             .stopped:
            return flowData?.totalTime ?? 0
        case .resting:
            return restData?.remainingTime ?? 0
        }
    }

    func startTask() {
//        task = TaskController.createTask(taskName: taskName, startTime: Date().timeIntervalSinceReferenceDate)
        taskData = TaskData()
        taskData!.start(at: Date().timeIntervalSinceReferenceDate)
        
        /* starting a new task automatically triggers a flow */
        startFlow()
    }

    func stopTask() {
//        task = TaskController.completeTask(task: task!, stopTime: currentTime)
        
        reset()
        taskData?.stop()
        taskData = nil
        mode = .stopped
    }

    func startFlow() {
        /* it's possible that we are coming from a resting state so stop the rest before proceeding with the flow */
        stopRest()
        
        /* if we are coming from a paused state we do no need to declare a new FlowData object */
        if (flowData == nil) {
            flowData = FlowData()
            flowCount += 1
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.flowData!.currentTime = Date().timeIntervalSinceReferenceDate
        }

        flowData!.start(at: Date().timeIntervalSinceReferenceDate)
        mode = .flowing
//        flow = FlowController.createFlow(task: task!, startTime: startTime)
    }
    
    func pauseFlow() {
        timer?.invalidate()
        timer = nil
        flowData?.stop()
        mode = .paused
    }

    func stopFlow() {
        flowData = nil
    }

    func startRest() {
        /* stop the flow before proceeding with the rest */
        stopFlow()
        
        restData = RestData()

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.restData!.currentTime = Date().timeIntervalSinceReferenceDate
        }

        let restTime: TimeInterval = calculateRestTime()
        restData!.start(at: Date().timeIntervalSinceReferenceDate, restTime: restTime)
        mode = .resting
        
        restCount += 1
    }

    func stopRest() {
        timer?.invalidate()
        timer = nil
        restData?.stop()
        restData = nil
    }
    
    
    private func calculateRestTime() -> TimeInterval {
        var restTime: Double = TimeInterval(5 * 60)
        if let flowData = flowData {
            if (flowData.additionalTime < TimeInterval(25 * 60)) {
                restTime = TimeInterval(5 * 60)
            } else if (flowData.additionalTime < TimeInterval(50 * 60)) {
                restTime = TimeInterval(8 * 60)
            } else if (flowData.additionalTime < TimeInterval(90 * 60)) {
                restTime = TimeInterval(10 * 60)
            } else {
                restTime = TimeInterval(15 * 60)
            }
        }
        return restTime
    }
    
    private func reset() {
        stopFlow()
        stopRest()
        
        taskName = ""
        flowCount = 0
        restCount = 0
    }
}
