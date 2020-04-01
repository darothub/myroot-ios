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
    
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
    
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
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
      
        do{
            let result = try context.fetch(fetchRequest)
            print("result\(result)")
            if result.count > 0{
                userData = result[0]
                print("UserdataHelper \(String(describing: result[0]))")
            }
            
         }catch{
             print(error)
         }

       
        return userData ?? UserData(context: context)
    }
    
    static func updateValue(key:String, value:Bool)->[String:Bool]{
        
//        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData")
      
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
    
    static func updateValue(key:String, value:String, where info:String)->[String:String]{
        
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", info)
        var newDataMapString:[String:String]=[String:String]()
        do{
            let result = try context.fetch(fetchRequest)
            if result.count > 0{
                let data = result[0]
                data.setValue(value, forKey: key)
                newDataMapString = [key: value]
                print("newData \(String(describing: data.name))")
            }
            do{
                try context.save()
                print("new data saved")
            }catch{
                print(error)
            }
              
         }catch{
             print(error)
         }
        return newDataMapString
    }
    
    static func intializeFirstData(key:String, valueString:String){
        do{
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
         
            newUser.setValue(valueString, forKey: key)
            print("new \(String(describing: valueString))")
            
            do{
                try context.save()
                print("Data saved successfully")
            }catch{
                print("Error updating entity")
            }
        }
       
    }
}
