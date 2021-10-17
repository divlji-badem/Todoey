//
//  Item.swift
//  Todoey
//
//  Created by Jelena Tasic on 17.10.21..
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    // relation with Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
