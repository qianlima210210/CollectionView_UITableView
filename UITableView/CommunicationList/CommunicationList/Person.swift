//
//  Person.swift
//  CommunicationList
//
//  Created by QDHL on 2017/12/30.
//  Copyright © 2017年 QDHL. All rights reserved.
//

import UIKit

class Person: NSObject {

    var name: String?
    var telNum: String?
    var title: String?
    
    init(name: String, telNum: String, title: String) {
        self.name = name
        self.telNum = telNum
        self.title = title
        
        super.init()
    }
}
