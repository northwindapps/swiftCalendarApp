//
//  export.swift
//  Newcalendar
//
//  Created by yujin on 2019/12/14.
//  Copyright © 2019 yujinyano. All rights reserved.
//
// https://medium.com/ios-os-x-development/classes-in-swift-for-newbies-529145228ba

import Foundation

class Export {
//    var name: String
//    var age: Int
//
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
    
//    func getName() -> String {
//        return "Your name is \(name)"
//    }
    
    func jsonExport(source:Dictionary<String, String>) -> Any{
        
        let jsonData = try? JSONSerialization.data(withJSONObject: source, options: .prettyPrinted)
        // Verifying it worked:
        let parsedObject = try! JSONSerialization.jsonObject(with: jsonData!, options: .allowFragments)
        
        return parsedObject
    }
    
    //https://stackoverflow.com/questions/28768015/how-to-save-an-array-as-a-json-file-in-swift
    func saveJsonFile(source:Dictionary<String, String>){
        let pathDirectory = getDocumentsDirectory()
        try? FileManager().createDirectory(at: pathDirectory, withIntermediateDirectories: true)
        let filePath = pathDirectory.appendingPathComponent("myJson.json")
    
        let json = try? JSONEncoder().encode(source)
        
        do {
            try json!.write(to: filePath)
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
    
    // https://stackoverflow.com/questions/28768015/how-to-save-an-array-as-a-json-file-in-swift
    // https://stackoverflow.com/questions/26386093/array-from-dictionary-keys-in-swift
    func readJsonFIle()-> ([String],[String]) {
        let k = [String]()
        let v = [String]()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filename = "myJson.json"
        
        let filePath = url.appendingPathComponent(filename).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
        
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, String> else { return (k,v)}
               
                return (Array(dict.keys),Array(dict.values))
                
            } catch {
//                print(error)
            }
        }
        
        return (k,v)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
}
