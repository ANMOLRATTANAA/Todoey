//
//  Item.swift
//  Todoey
//
//  Created by Anmol Rattan on 18/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import Foundation
import RealmSwift
class Item : Object  {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool =  false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "item")
}
