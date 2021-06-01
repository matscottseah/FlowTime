//
//  Predicates.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

func DatePredicate(date: Date) -> NSPredicate {
    var calendar = Calendar.current
    calendar.timeZone = NSTimeZone.local

    let dateFrom = calendar.startOfDay(for: date)
    let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)

    let fromPredicate = NSPredicate(format: "%@ >= %@", date as NSDate, dateFrom as NSDate)
    let toPredicate = NSPredicate(format: "%@ < %@", date as NSDate, dateTo! as NSDate)
    let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])

    return datePredicate
}
