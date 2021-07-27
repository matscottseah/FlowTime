//
//  RestController.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

class RestController {
    static func createRestFor(task: Task, startTime: Date) -> Rest {
        let rest = Rest(context: viewContext)
        rest.id = UUID()
        rest.startTime = startTime
        var _ = PersistenceController.shared.save()

        var _ = TaskController.addRestFor(task: task, rest: rest)
        
        return rest
    }

    static func complete(rest: Rest, stopTime: Date) -> Rest {
        rest.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return rest
    }
    
    static func delete(rest: Rest) -> Bool {
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

    static func getRestsBy(date: Date) -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")
        fetchRequest.predicate = DayPredicateFor(date: date)

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }
    
    static func getTotalRestsBy(date: Date) -> Int {
        return self.getRestsBy(date: date).count
    }

    static func getTotalRestTimeBy(date: Date) -> TimeInterval {
        let rests = self.getRestsBy(date: date)
        var totalTime: TimeInterval = 0
        for rest in rests {
            totalTime += (rest.stopTime! - rest.startTime!)
        }

        return totalTime
    }
    
    static func getRestsForPastWeek() -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")
        fetchRequest.predicate = PastWeekPredicateFor(date: Date())

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }
    
    static func getRestsForWeekWith(offset: Int) -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")
        fetchRequest.predicate = WeekPredicateFor(date: Date(), offset: offset)

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }
    
    static func getRestTimesForWeekWith(offset: Int) -> [TimeInterval] {
        let restsForWeek = self.getRestsForWeekWith(offset: offset).sorted(by: {$0.startTime!})
        var restTimes: [TimeInterval] = [Double](repeating: 0.0, count: 7)
        
        for rest in restsForWeek {
            guard let day = Calendar.current.dateComponents([.weekday], from: rest.startTime!).weekday else { continue }
            restTimes[day - 1] += (rest.stopTime! - rest.startTime!)
        }
        
        return restTimes
    }
    
    static func getRestsForMonthWith(offset: Int) -> [Rest] {
        let rests: [Rest]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rest")
        fetchRequest.predicate = MonthPredicateFor(date: Date(), offset: offset)

        do {
            rests = try viewContext.fetch(fetchRequest) as! [Rest]
        } catch {
            fatalError("Failed to fetch rests: \(error)")
        }

        return rests
    }
    
    static func getRestTimesForMonthWith(offset: Int) -> [TimeInterval] {
        let restsForMonth = self.getRestsForMonthWith(offset: offset).sorted(by: {$0.startTime!})
        var restTimes: [TimeInterval] = [Double](repeating: 0.0, count: 5)
        var currentWeek = 0
        
        for rest in restsForMonth {
            let week = weekOfMonthFrom(date: rest.startTime!)
            restTimes[week - 1] += (rest.stopTime! - rest.startTime!)
        }
        
        return restTimes
    }
}
