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
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        for _ in 0..<10 {
            let flow = Flow(context: context)
            let randomHour = Int.random(in: 1...12)
            let randomMinute = Int.random(in: 1...12)
            let randomSecond = Int.random(in: 1...12)
            
            flow.id = UUID()
            flow.startTime = Date()
            flow.stopTime = calendar.date(byAdding: DateComponents(hour: randomHour, minute: randomMinute, second: randomSecond), to: flow.startTime!)
            flow.task = randomString(length: 10)
            flow.interruptionCount = Int32.random(in: 1...100)
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
