//
//  UserDataClass.swift
//  iOS Sample
//
//  Created by Chandra Hasan on 17/10/23.
//

import Foundation


class UserDataClass {
    
    static let shared = UserDataClass()
    let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    var documentsDirectoryPath = NSURL()

    var jsonFilePath = NSURL()
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    init(){
         documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

        jsonFilePath = documentsDirectoryPath.appendingPathComponent("Users.json")! as NSURL
        
        if !fileManager.fileExists(atPath: jsonFilePath.absoluteString!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: jsonFilePath.absoluteString!, contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
    }
    
    func registeruser(user: NSDictionary)-> Bool {
        
        let getData = retrieveFromJsonFile()
        let user_data = NSMutableDictionary()
        let arr_user_data = NSMutableArray()
        if(getData.count > 0) {
            for dict  in getData {
                let old_user_data = NSMutableDictionary()
                old_user_data.setValue(dict.value(forKey: "name"), forKey: "name")
                old_user_data.setValue(dict.value(forKey: "mailID"), forKey: "mailID")
                old_user_data.setValue(dict.value(forKey: "password"), forKey: "password")
                arr_user_data.add(old_user_data)
            }
        }
        user_data.setValue(user.value(forKey: "name"), forKey: "name")
        user_data.setValue(user.value(forKey: "mailID"), forKey: "mailID")
        user_data.setValue(user.value(forKey: "password"), forKey: "password")
        arr_user_data.add(user_data)
        
        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: arr_user_data, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
            print(jsonString as Any)
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
            return false
        }

        // Write that JSON to the file created earlier
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("Users.json")
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.write(jsonData as Data)
            print("JSON data was written to teh file successfully!")
            return true
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
            return false
        }
    }
    
    func retrieveFromJsonFile()-> [NSDictionary] {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("Users.json")

        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let personArray = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary] else { return [] }
            return personArray
        } catch {
            print(error)
        }
        return []
    }
    
    func isUserValide(email_id: String, password: String)-> Bool {
        let usersData = retrieveFromJsonFile()
        if(usersData.count > 0) {
            for dict in usersData {
                if((dict as AnyObject).value(forKey: "mailID") as! String  == email_id && (dict as AnyObject).value(forKey: "password") as! String == password) {
                    return true
                }
            }
        }
        return false
    }
}
