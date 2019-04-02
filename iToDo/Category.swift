//
//  Category.swift
//  iToDo
//
//  Created by bagasstb on 03/04/19.
//  Copyright © 2019 xProject. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
