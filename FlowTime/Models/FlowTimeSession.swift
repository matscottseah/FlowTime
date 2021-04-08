//
//  FlowTimeSession.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/7/21.
//

import Foundation

struct FlowTimeSession: Codable, Identifiable {
    var id: UUID
    var startTime: Date
    var stopTime: Date
    var elapsedTime: TimeInterval
    var interruptionCount: Int
}
