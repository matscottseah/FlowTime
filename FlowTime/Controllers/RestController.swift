//
//  RestController.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

class RestController {
    static func createRest(task: Task, startTime: Date) -> Rest {
        let rest = Rest(context: viewContext)
        rest.id = UUID()
        rest.startTime = startTime
        var _ = PersistenceController.shared.save()

        var _ = TaskController.addRest(task: task, rest: rest)
        
        return rest
    }

    static func completeRest(rest: Rest, stopTime: Date) -> Rest {
        rest.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return rest
    }
    
    static func deleteRest(rest: Rest) -> Bool {
        viewContext.delete(rest)
        return PersistenceController.shared.save()
    }

    static func getAllRests() -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }

    static func getRestsByDate(date: Date) -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")

        fetchRequest.predicate = DatePredicate(date: date)

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }

    static func getTotalRestsByDate(date: Date) -> Int {
        let rests = self.getRestsByDate(date: date)
        return rests.count
    }

    static func getTotalRestTimeByDate(date: Date) -> TimeInterval {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        let rests = self.getRestsByDate(date: date)

        var totalTime: Double = 0
        for rest in rests {
            if let startTime = rest.startTime, let stopTime = rest.stopTime {
                totalTime += stopTime.timeIntervalSince(startTime)
            }
        }

        return totalTime
    }
}
