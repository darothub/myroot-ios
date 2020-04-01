//
//  UserData+CoreDataProperties.swift
//  
//
//  Created by Darot on 01/04/2020.
//
//

import UIKit
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
    @NSManaged public var token: String?
    @NSManaged public var newTree: Bool
    @NSManaged public var loggedIn: Bool

}
