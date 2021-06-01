//
//  TaskController.swift
//  FlowTime
//
//  Created by Matthew Seah on 5/21/21.
//

import CoreData

class TaskController {
    static func createTask(startTime: Date, taskName: String) -> Task {
        let task = Task(context: viewContext)
        task.id = UUID()
        task.startTime = startTime
        task.task = taskName
        var _ = PersistenceController.shared.save()

        return task
    }
    
    static func addFlow(task: Task, flow: Flow) -> Task {
        task.addToFlows(flow)
        
        var _ = PersistenceController.shared.save()
        return task
    }
    
    static func addRest(task: Task, rest: Rest) -> Task {
        task.addToRests(rest)
        
        var _ = PersistenceController.shared.save()
        return task
    }
    
    static func completeTask(task: Task, stopTime: Date) -> Task {
        task.stopTime = stopTime

        var _ = PersistenceController.shared.save()
        return task
    }

    static func deleteTask(task: Task) -> Bool {
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

    static func getTasksByDate(date: Date) -> [Task] {
        let tasks: [Task]
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flow")

        fetchRequest.predicate = DatePredicate(date: date)

        do {
            tasks = try viewContext.fetch(fetchRequest) as! [Task]
        } catch {
            fatalError("Failed to fetch tasks: \(error)")
        }

        return tasks
    }

    static func getTotalTaksByDate(date: Date) -> Int {
        let tasks = self.getTasksByDate(date: date)
        return tasks.count
    }
}
