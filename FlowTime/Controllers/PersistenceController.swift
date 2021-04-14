//
//  PersistenceController.swift
//  FlowTime
//
//  Created by Matthew Seah on 4/12/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        for _ in 0..<10 {
            let flow = Flow(context: context)
            flow.id = UUID()
            flow.startTime = Date()
            flow.stopTime = Date()
            flow.task = "Test task"
            flow.interruptionCount = 13
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
