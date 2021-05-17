////
////  FlowController.swift
////  FlowTime
////
////  Created by Matthew Seah on 4/13/21.
////
//
//import CoreData
//
//class FlowController {
//    //  Use in production
////    static let viewContext = (PersistenceController.shared.container as NSPersistentContainer).viewContext
//
//    // Use in preview
//    static let viewContext = PersistenceController.preview.container.viewContext
//
//    static func createFlow() -> Flow {
//        let flow = Flow(context: viewContext)
//        flow.id = UUID()
//        flow.startTime = Date()
//        var _ = PersistenceController.shared.save()
//
//        return flow
//    }
//
//    static func deleteFlow(flow: Flow) -> Bool {
//        viewContext.delete(flow)
//        return PersistenceController.shared.save()
//    }
//
//    static func update(flow: Flow,
//                       stopTime: Date? = nil,
//                       task: String? = nil,
//                       interruptionCount: Int32? = nil) -> Flow {
//
//        flow.stopTime = stopTime ?? flow.stopTime
//        flow.task = task ?? flow.task
//        flow.interruptionCount = interruptionCount ?? flow.interruptionCount
//
//        var _ = PersistenceController.shared.save()
//        return flow
//    }
//
//    static func getAllFlows() -> [Flow] {
//        let flows: [Flow]
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
//
//        do {
//            flows = try viewContext.fetch(fetchRequest) as! [Flow]
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//
//        return flows
//    }
//
//    static func getFlowsByDate(date: Date) -> [Flow] {
//        let flows: [Flow]
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")
//
//        var calendar = Calendar.current
//        calendar.timeZone = NSTimeZone.local
//
//        let dateFrom = calendar.startOfDay(for: date)
//        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
//
//        let fromPredicate = NSPredicate(format: "%@ >= %@", date as NSDate, dateFrom as NSDate)
//        let toPredicate = NSPredicate(format: "%@ < %@", date as NSDate, dateTo! as NSDate)
//        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
//
//        fetchRequest.predicate = datePredicate
//
//        do {
//            flows = try viewContext.fetch(fetchRequest) as! [Flow]
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//
//        return flows
//    }
//
//    static func getTotalFlowsByDate(date: Date) -> Int {
//        let flowsForDate = self.getFlowsByDate(date: date)
//        return flowsForDate.count
//    }
//
//    static func getTotalFlowTimeByDate(date: Date) -> DateComponents {
//        var calendar = Calendar.current
//        calendar.timeZone = NSTimeZone.local
//
//        let flowsForDate = self.getFlowsByDate(date: date)
//
//        var totalTime: Double = 0
//        for flow in flowsForDate {
//            if let startTime = flow.startTime, let stopTime = flow.stopTime {
//                totalTime += stopTime.timeIntervalSince(startTime)
//            }
//        }
//
//        return dateComponentsFromTimeInterval(timeInterval: totalTime)
//    }
//
//    static func getTotalInterruptionsByDate(date: Date) -> Int {
//        let flowsForDate = self.getFlowsByDate(date: date)
//        return Int(flowsForDate.reduce(0) { $0 + $1.interruptionCount })
//    }
//}
