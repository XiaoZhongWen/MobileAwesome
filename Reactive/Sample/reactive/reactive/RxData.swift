//
//  RxData.swift
//  reactive
//
//  Created by 肖仲文 on 2021/6/21.
//

import UIKit

class ContactModel {
    var username: String?
    var nickname: String?
    var headUrl: String?
    var depts: String?
}

public protocol SectionModelType {
    associatedtype Item

    var items: [Item] { get }

    init(original: Self, items: [Item])
}

struct SectionOfContactModel {
    var header: String
    var items: [ContactModel]
}

extension SectionOfContactModel: SectionModelType {
    typealias Item = ContactModel
    init(original: SectionOfContactModel, items: [ContactModel]) {
        self = original
        self.items = items
    }
}

public final class PublishSubject<Element> : Observable<Element> {
    
}

let datasource = PublishSubject<[SectionOfContactModel]>()
let tableView = UITableView.init()
datasource.bind(to: tableView.)
