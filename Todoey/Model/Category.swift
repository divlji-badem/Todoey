//
//  Category.swift
//  Todoey
//
//  Created by Jelena Tasic on 17.10.21..
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    // relationship each category can have more than once items
    let items = List<Item>()
}
