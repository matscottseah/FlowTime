//
//  FlowController.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/13/21.
//

import CoreData

class FlowController {
    static func createFlowFor(task: Task, startTime: Date) -> Flow {
        let flow = Flow(context: viewContext)
        flow.id = UUID()
        flow.startTime = startTime
        var _ = PersistenceController.shared.save()
        
        var _ = TaskController.addFlowFor(task: task, flow: flow)

        return flow
    }
    
    static func complete(flow: Flow, stopTime: Date) -> Flow {
        flow.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return flow
    }

    static func delete(flow: Flow) -> Bool {
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

    static func getFlowsBy(date: Date) -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
        fetchRequest.predicate = DayPredicateFor(date: date)

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch flows: \(error)")
        }

        return flows
    }
    
    static func getTotalFlowsBy(date: Date) -> Int {
        return self.getFlowsBy(date: date).count
    }

    static func getTotalFlowTimeBy(date: Date) -> TimeInterval {
        let flows = self.getFlowsBy(date: date)
        var totalTime: TimeInterval = 0
        for flow in flows {
            totalTime += (flow.stopTime! - flow.startTime!)
        }
        
        return totalTime
    }
    
    static func getFlowsForPastWeek() -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
        fetchRequest.predicate = PastWeekPredicateFor(date: Date())

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch flows: \(error)")
        }

        return flows
    }
    
    static func getFlowsForWeekWith(offset: Int) -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
        fetchRequest.predicate = WeekPredicateFor(date: Date(), offset: offset)

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch flows: \(error)")
        }

        return flows
    }
    
    static func getFlowTimesForWeekWith(offset: Int) -> [TimeInterval] {
        let flowsForWeek = self.getFlowsForWeekWith(offset: offset).sorted(by: {$0.startTime!})
        var flowTimes: [TimeInterval] = [Double](repeating: 0.0, count: 7)

        for flow in flowsForWeek {
            guard let day = Calendar.current.dateComponents([.weekday], from: flow.startTime!).weekday else { continue }
            flowTimes[day - 1] += (flow.stopTime! - flow.startTime!)
        }

        return flowTimes
    }
    
    static func getFlowsForMonthWith(offset: Int) -> [Flow] {
        let flows: [Flow]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
        fetchRequest.predicate = MonthPredicateFor(date: Date(), offset: offset)

        do {
            flows = try viewContext.fetch(fetchRequest) as! [Flow]
        } catch {
            fatalError("Failed to fetch flows: \(error)")
        }

        return flows
    }
    
    static func getFlowTimesForMonthWith(offset: Int) -> [TimeInterval] {
        let flowsForMonth = self.getFlowsForMonthWith(offset: offset).sorted(by: {$0.startTime!})
        var flowTimes: [TimeInterval] = [Double](repeating: 0.0, count: 5)
        var currentWeek = 0
        
        for flow in flowsForMonth {
            let week = weekOfMonthFrom(date: flow.startTime!)
            flowTimes[week - 1] += (flow.stopTime! - flow.startTime!)
        }
        
        return flowTimes
    }
}
