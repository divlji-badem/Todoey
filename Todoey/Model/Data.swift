//
//  Data.swift
//  Todoey
//
//  Created by Jelena Tasic on 17.10.21..
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
