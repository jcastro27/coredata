//
//  CoreDataManager.swift
//  CoreData1.1
//
//  Created by Joseph Castro on 7/2/22.
//

import Foundation
import CoreData




class CoreDataManager{
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "CoreData1_1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchUsers()-> [User]
    {
        let fetchRequest = UserEntity.fetchRequest()
        let entities = try? persistentContainer.viewContext.fetch(fetchRequest)
        if let entities = entities {
            let userentities = entities as? [UserEntity]
            if let userentities = userentities
            {
              return  userentities.map { userEntity in
                    User(name: userEntity.name, username: userEntity.username, email: userEntity.email)
                }
            }
        }
        
        
        return []
    }
    
    func addUsers(users: [User]){
        let userEntities = users.map { user -> UserEntity in
            let Userentity = NSEntityDescription.entity(forEntityName: "UserEntity", in: persistentContainer.viewContext)!
            let entity = UserEntity(entity: Userentity, insertInto: persistentContainer.viewContext)
            entity.name = user.name
            entity.username = user.username
            entity.email = user.email
            
            return entity
            
        }
        saveContext()
    }
    
}
