//
//  Predicates.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

func DayPredicateFor(date: Date) -> NSPredicate {
    let fromPredicate = NSPredicate(format: "startTime >= %@", date.startOfDay as NSDate)
    let toPredicate = NSPredicate(format: "startTime <= %@", date.endOfDay as NSDate)
    return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
}

func PastWeekPredicateFor(date: Date) -> NSPredicate {
    let dateFrom = Calendar.current.date(byAdding: .day, value: -7, to: date.startOfDay)
    let fromPredicate = NSPredicate(format: "startTime >= %@", dateFrom! as NSDate)
    let toPredicate = NSPredicate(format: "startTime < %@", date.startOfDay as NSDate)
    return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
}

func WeekPredicateFor(date: Date, offset: Int) -> NSPredicate {
    let dateFrom = Calendar.current.date(byAdding: .day, value: -7 * offset, to: date.startOfWeek)
    let fromPredicate = NSPredicate(format: "startTime >= %@", dateFrom! as NSDate)
    let toPredicate = NSPredicate(format: "startTime <= %@", dateFrom!.endOfWeek.endOfDay as NSDate)
    return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
}

func MonthPredicateFor(date: Date, offset: Int) -> NSPredicate {
    let dateFrom = Calendar.current.date(byAdding: .month, value: -1 * offset, to: date.startOfMonth)
    let fromPredicate = NSPredicate(format: "startTime >= %@", dateFrom! as NSDate)
    let toPredicate = NSPredicate(format: "startTime <= %@", dateFrom!.endOfMonth.endOfDay as NSDate)
    return NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
}
