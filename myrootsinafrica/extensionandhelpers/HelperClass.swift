//
//  setViewShadowExtension.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


class HelperClass{
    
    
  
    static var newDataMap:[String:Bool]?
    
//
//    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    static let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    
    static func validateField(textFields:UITextField...) -> [UITextField:Bool]{
        var result = [UITextField:Bool]()
        for field in textFields{
            guard let fieldText = field.text else{
                fatalError("\(field) is nil")
            }
            if fieldText.isEmpty {
                result[field] = false
            }
        }
        return result
    }
    
    static func getUserData(predicate:String)->User{
        let thisRealm = try! Realm()
        let user = thisRealm.objects(User.self).filter(predicate)
        print("found: \(user)")
        if user.count != 0 {
            
            return user.first!
        }
        else{
            return User()
        }
        
    }
    
//    static func updateValue(filterValue:String, key:Bool)->[String:Bool]{
//        var resultMap:[String:Bool] = [String:Bool]()
//        DispatchQueue(label: "background").async {
//                autoreleasepool {
//                    let thisRealm = try! Realm()
//                    let user = thisRealm.objects(User.self).filter(filterValue)
//                    if user != nil{
//                        try! thisRealm.write {
//                            user.first?.loggedIn = false
//                        }
//                    }
//                }
//            }
//        return resultMap
//    }
    
    
     static func changeToObjectUser(from userDetails:UserDetails) -> User{
         let theUser = User()
         theUser.name = userDetails.name
         theUser.email = userDetails.email
         theUser.password = userDetails.password
         theUser.country = userDetails.country
         theUser.phone = userDetails.phone
         return theUser
     }
    
    static func changeToUserDetails(from user:User)-> UserDetails{
        var theUser = UserDetails()
        theUser.name = user.name
        theUser.email = user.email
        theUser.password = user.password
        theUser.country = user.country
        theUser.phone = user.phone
        return theUser
    }

    

}



enum Counter{
    case one(Int)
    case more(Int)
}

enum TimeOfTheDay{
    case morning(Int)
    case afternoon(Int)
    case evening(Int)
}
