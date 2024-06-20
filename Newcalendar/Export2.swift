//
//  export.swift
//  Newcalendar
//
//  Created by yujin on 2019/12/14.
//  Copyright © 2019 yujinyano. All rights reserved.
//
// https://medium.com/ios-os-x-development/classes-in-swift-for-newbies-529145228ba

import Foundation

class Export2 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func getName() -> String {
        return "Your name is \(name)"
    }
    
}
