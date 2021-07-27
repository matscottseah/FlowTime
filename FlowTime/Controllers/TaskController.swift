//
//  TaskController.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

class TaskController {
    static func createTaskWith(startTime: Date, taskName: String) -> Task {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.startTime = startTime
        task.task = taskName
        var _ = PersistenceController.shared.save()

        return task
    }
    
    static func addFlowFor(task: Task, flow: Flow) -> Task {
        task.addToFlows(flow)
        
        var _ = PersistenceController.shared.save()
        return task
    }
    
    static func addRestFor(task: Task, rest: Rest) -> Task {
        task.addToRests(rest)
        
        var _ = PersistenceController.shared.save()
        return task
    }
    
    static func complete(task: Task, stopTime: Date) -> Task {
        task.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return task
    }

    static func delete(task: Task) -> Bool {
        viewContext.delete(task)
        return PersistenceController.shared.save()
    }

    static func getAllTasks() -> [Task] {
        let tasks: [Task]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")

        do {
            tasks = try viewContext.fetch(fetchRequest) as! [Task]
        } catch {
            fatalError("Failed to fetch tasks: \(error)")
        }

        return tasks
    }

    static func getTasksBy(date: Date) -> [Task] {
        let tasks: [Task]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = DayPredicateFor(date: date)

        do {
            tasks = try viewContext.fetch(fetchRequest) as! [Task]
        } catch {
            fatalError("Failed to fetch tasks: \(error)")
        }

        return tasks
    }

    static func getTotalTasksBy(date: Date) -> Int {
        return self.getTasksBy(date: date).count
    }
    
    static func getTasksForPastWeek() -> [Task] {
        let tasks: [Task]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = PastWeekPredicateFor(date: Date())

        do {
            tasks = try viewContext.fetch(fetchRequest) as! [Task]
        } catch {
            fatalError("Failed to fetch tasks: \(error)")
        }

        return tasks
    }
}
