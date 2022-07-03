//
//  Entities.swift
//  CoreData1.1
//
//  Created by Joseph Castro on 7/2/22.
//

import Foundation
import CoreData

class UserEntity: NSManagedObject{
    @NSManaged var name: String
    @NSManaged var username: String
    @NSManaged var email: String
}
