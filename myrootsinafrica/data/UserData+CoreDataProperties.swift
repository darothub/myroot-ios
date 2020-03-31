//
//  UserData+CoreDataProperties.swift
//  
//
//  Created by Darot on 30/03/2020.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var country: String?
    @NSManaged public var phone: String?
    @NSManaged public var loggedIn: Bool
    @NSManaged public var newTree: Bool

}
