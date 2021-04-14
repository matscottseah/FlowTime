//
//  FlowController.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/13/21.
//

import CoreData

class FlowController {
    static let viewContext = (PersistenceController.shared.container as NSPersistentContainer).viewContext
    
    static func createFlow() -> Flow {
        let flow = Flow(context: viewContext)
        flow.id = UUID()
        flow.startTime = Date()
        var _ = PersistenceController.shared.save()
        
        return flow
    }
    
    static func deleteFlow(flow: Flow) -> Bool {
        viewContext.delete(flow)
        return PersistenceController.shared.save()
    }
    
    static func update(flow: Flow,
                       stopTime: Date? = nil,
                       task: String? = nil,
                       interruptionCount: Int32? = nil) -> Flow {
        
        flow.stopTime = stopTime ?? flow.stopTime
        flow.task = task ?? flow.task
        flow.interruptionCount = interruptionCount ?? flow.interruptionCount
        
        var _ = PersistenceController.shared.save()
        return flow
    }
}
