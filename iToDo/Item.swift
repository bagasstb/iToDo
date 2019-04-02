//
//  Item.swift
//  iToDo
//
//  Created by bagasstb on 28/03/19.
//  Copyright © 2019 xProject. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
