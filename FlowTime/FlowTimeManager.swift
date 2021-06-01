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
    private var task: Task?
    private var flow: Flow?
    private var rest: Rest?

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
        /* TaskData */
        taskData = TaskData()
        taskData!.start(at: Date().timeIntervalSinceReferenceDate)
        
        /* core data */
        task = TaskController.createTask(startTime: Date(), taskName: taskName)
        
        /* new task triggers new flow */
        startFlow()
    }

    func stopTask() {
        /* core data */
        if let task = task {
            var _  = TaskController.completeTask(task: task, stopTime: Date())
        }
        task = nil
        
        /* stop TaskData */
        taskData?.stop()
        taskData = nil
        
        /* cleanup */
        reset()
        
        mode = .stopped
    }

    func startFlow() {
        /* stop Rest */
        if (restData != nil) {
            stopRest()
        }
        
        /* init FlowData */
        if (flowData == nil) {
            flowData = FlowData()
            flowCount += 1
            
            /* core data*/
            if let task = task {
                flow = FlowController.createFlow(task: task, startTime: Date())
            }
        }

        /* start FlowData */
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.flowData!.currentTime = Date().timeIntervalSinceReferenceDate
        }
        flowData!.start(at: Date().timeIntervalSinceReferenceDate)
        
        mode = .flowing
    }
    
    func pauseFlow() {
        /* stop FlowData */
        timer?.invalidate()
        timer = nil
        flowData?.stop()
        
        mode = .paused
    }

    func stopFlow() {
        /* core data */
        if let flow = flow {
            var _ = FlowController.completeFlow(flow: flow, stopTime: Date())
        }
        
        flowData = nil
        flow = nil
    }

    func startRest() {
        let restTime: TimeInterval = calculateRestTime()
        
        /* stop Flow */
        if (flowData != nil) {
            stopFlow()
        }
        
        /* RestData */
        restData = RestData()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.restData!.currentTime = Date().timeIntervalSinceReferenceDate
        }
        restData!.start(at: Date().timeIntervalSinceReferenceDate, restTime: restTime)
        
        /* core data */
        if let task = task {
            rest = RestController.createRest(task: task, startTime: Date())
        }
        
        restCount += 1
        
        mode = .resting
    }

    func stopRest() {
        /* stop RestData */
        timer?.invalidate()
        timer = nil
        restData?.stop()
        restData = nil
        
        /* core data */
        if let rest = rest {
            var _ = RestController.completeRest(rest: rest, stopTime: Date())
        }
        
        rest = nil
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
