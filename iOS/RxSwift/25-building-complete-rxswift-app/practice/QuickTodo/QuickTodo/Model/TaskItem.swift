//
//  TaskItem.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/14.
//

import RealmSwift
import RxDataSources

class TaskItem: Object {
    @objc dynamic var uid: Int = 0
    @objc dynamic var title = ""
    @objc dynamic var added = Date()
    @objc dynamic var checked: Date? = nil

    override class func primaryKey() -> String? {
        return "uid"
    }
}

extension TaskItem: IdentifiableType {
    var identity: Int {
        return self.isInvalidated ? 0 : uid
    }
}

