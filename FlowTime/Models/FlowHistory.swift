//
//  FlowHistory.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/9/21.
//

import Foundation

//class FlowHistory: ObservableObject {
//    var flows = [Flow]()
//
//    var totalSessions: Int {
//        return flows.count
//    }
//
//    var avgFlowLength: Int {
//        if flows.count == 0 {
//            return 0
//        }
//        return flows.reduce(0) { $0 + $1.elapsedTime }
//    }
//
//    var avgInterruptions: Int {
//        if flows.count == 0 {
//            return 0
//        }
//        return flows.reduce(0) { $0 + $1.interruptionCount }
//    }
//
//    var longestFlow: Int {
//        return flows.map{$0.elapsedTime}.max() ?? 0
//    }
//
//    func add(flow: Flow) {
//        flows.append(flow)
//    }
//
//    func remove(flow: Flow) {
//        if let index = flows.firstIndex(of: flow) {
//            flows.remove(at: index)
//        }
//    }
//}
