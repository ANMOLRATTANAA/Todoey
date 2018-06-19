//
//  Category.swift
//  Todoey
//
//  Created by Anmol Rattan on 18/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import Foundation
import RealmSwift
class Category : Object {
    @objc dynamic var name : String = ""
    let item = List<Item>()
    
}

