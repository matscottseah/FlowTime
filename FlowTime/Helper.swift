//
//  Helper.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/14/21.
//

import Foundation
import SwiftUI

enum TimeFormat {
    case hours
    case minutes
    case seconds
}

let formatterHMS: DateComponentsFormatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.hour, .minute, .second]
    f.zeroFormattingBehavior = .pad
    return f
}()

let formatterHM: DateComponentsFormatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.hour, .minute]
    f.zeroFormattingBehavior = .pad
    return f
}()

let formatterH: DateComponentsFormatter = {
    let f = DateComponentsFormatter()
    f.allowedUnits = [.hour]
    f.zeroFormattingBehavior = .pad
    return f
}()

func weekOfMonthFrom(date: Date) -> Int {
    let day = Calendar.current.component(.day, from: date)
    if (day < 8)       { return 1 }
    else if (day < 15) { return 2 }
    else if (day < 22) { return 3 }
    else if (day < 29) { return 4 }
    else               { return 5 }
}

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
         if conditional {
             return AnyView(content(self))
         } else {
             return AnyView(self)
         }
     }
}

extension TimeInterval {
    var formattedHMS: String {
        return formatterHMS.string(from: self)!
    }
    var formattedHM: String {
        return formatterHM.string(from: self)!
    }
    var formattedH: String {
        return formatterH.string(from: self)!
    }

    var toMinutes: Double {
        return self / 60
    }

    var toHours: Double {
        return self / 3600
    }
}

extension Date {
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.month, .year], from: self)) ?? self
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return Calendar.current.date(byAdding: components, to: self.startOfMonth) ?? self
    }
    
    var startOfWeek: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) ?? self
    }

    var endOfWeek: Date {
        var components = DateComponents()
        components.day = 6
        return Calendar.current.date(byAdding: components, to: self.startOfWeek) ?? self
    }
    
    var startOfDay : Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
    
    func month() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
    
    func weekOf() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        return dateFormatter.string(from: self.startOfWeek)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

extension Array {
    func sorted<T: Comparable>(by compare: (Element) -> T, asc ascendant: Bool = true) -> Array {
        return self.sorted {
            if ascendant {
                return compare($0) < compare($1)
            }

            return compare($0) > compare($1)
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}


