//
//  FlowController.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/13/21.
//

import CoreData

class FlowController {
    static func createFlow(task: Task, startTime: Date) -> Flow {
        let flow = Flow(context: viewContext)
        flow.id = UUID()
        flow.startTime = startTime
        var _ = PersistenceController.shared.save()
        
        var _ = TaskController.addFlow(task: task, flow: flow)

        return flow
    }
    
    static func completeFlow(flow: Flow, stopTime: Date) -> Flow {
        flow.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return flow
    }

    static func deleteFlow(flow: Flow) -> Bool {
        viewContext.delete(flow)
        return PersistenceController.shared.save()
    }

    static func getAllFlows() -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch flows: \(error)")
        }

        return flows
    }

    static func getFlowsByDate(date: Date) -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")

        fetchRequest.predicate = DatePredicate(date: date)

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }

        return flows
    }

    static func getTotalFlowsByDate(date: Date) -> Int {
        let flows = self.getFlowsByDate(date: date)
        return flows.count
    }

    static func getTotalFlowTimeByDate(date: Date) -> TimeInterval {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        let flows = self.getFlowsByDate(date: date)

        var totalTime: Double = 0
        for flow in flows {
            if let startTime = flow.startTime, let stopTime = flow.stopTime {
                totalTime += stopTime.timeIntervalSince(startTime)
            }
        }

        return totalTime
    }
}
