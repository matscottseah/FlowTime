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
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let now = Date()

        for i in 0..<10 {
            let task = Task(context: context)
            task.id = UUID()
            task.startTime = calendar.date(byAdding: DateComponents(hour: i, minute: i, second: i), to: now)
            task.task = "Task \(i)"
            
            let flow1 = Flow(context: context)
            flow1.id = UUID()
            flow1.startTime = task.startTime
            flow1.stopTime = calendar.date(byAdding: DateComponents(hour: i, minute: i, second: i), to: flow1.startTime!)
            
            let rest1 = Rest(context: context)
            rest1.id = UUID()
            rest1.startTime = flow1.stopTime
            rest1.recommendedTime = Double.random(in: 1...25)
            rest1.stopTime = calendar.date(byAdding: DateComponents(hour: i, minute: i, second: i), to: rest1.startTime!)
            
            task.stopTime = rest1.stopTime
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
