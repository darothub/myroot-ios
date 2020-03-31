//
//  setViewShadowExtension.swift
//  myrootsinafrica
//
//  Created by Darot on 18/03/2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData

class HelperClass{
    
    
    static var userData:UserData?
    static var newDataMap:[String:Bool]?
    
    
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
    
    static func getUserData()->UserData{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
      
        do{
            let result = try context.fetch(fetchRequest)
            userData = result[0]
            print("UserdataHelper \(String(describing: userData))")
             
         }catch{
             print(error)
         }

        return userData!
    }
    
    static func updateValue(key:String, value:Bool)->[String:Bool]{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
      
        do{
            let result = try context.fetch(fetchRequest)
            if result.count > 0{
                let data = result[0]
                data.setValue(value, forKey: key)
                newDataMap = [key: value]
                print("newData \(String(describing: newDataMap))")
            }
            do{
                try context.save()
                print("new data saved")
            }catch{
                print("Error updating entity")
            }
              
         }catch{
             print(error)
         }
        return newDataMap!
    }
    
    static func intializeFirstData(key:String, value:Any){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
            if value is String || value is Bool{
               newUser.setValue(value, forKey: key)
            }
            
            do{
                try context.save()
                print("Data saved successfully")
            }catch{
                print("Error updating entity")
            }
        }
       
    }
}
