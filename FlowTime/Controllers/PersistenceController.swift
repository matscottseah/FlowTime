//
//  PersistenceController.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/12/21.
//

import CoreData

//  Use in production
//let viewContext = (PersistenceController.shared.container as NSPersistentContainer).viewContext

// Use in preview
let viewContext = PersistenceController.preview.container.viewContext

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<90 {
            let rand = Int.random(in: 1...3)
            for j in 0..<rand {
                let dateWithOffset = calendar.date(byAdding: .day, value: -1 * i, to: today)?.startOfDay
                
                let task = Task(context: context)
                task.id = UUID()
                task.startTime = dateWithOffset
                task.task = "Task \(i)"

                let flow = Flow(context: context)
                flow.id = UUID()
                flow.startTime = task.startTime
                flow.stopTime = calendar.date(byAdding: .hour, value: Int.random(in: 0...6), to: flow.startTime!)
                flow.stopTime = calendar.date(byAdding: .minute, value: Int.random(in: 0...60), to: flow.stopTime!)
                
                let rest = Rest(context: context)
                rest.id = UUID()
                rest.startTime = flow.stopTime
                rest.recommendedTime = Double.random(in: 1...25)
                rest.stopTime = calendar.date(byAdding: .minute, value: Int.random(in: 0...60), to: rest.startTime!)
                
                task.stopTime = rest.stopTime
                let _ = TaskController.addFlowFor(task: task, flow: flow)
                let _ = TaskController.addRestFor(task: task, rest: rest)
            }
        }
        
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            fatalError("Unresolved error \(saveError), \(saveError.userInfo)")
        }
        
        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FlowTime")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() -> Bool {
        let context = container.viewContext
        var saveError: NSError?

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                saveError = error as NSError
                fatalError("Unresolved error \(saveError!), \(saveError!.userInfo)")
            }
        }
        
        return saveError == nil
    }
}
