//
//  SectionOfContactModel.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/4.
//

import Foundation
import RxDataSources

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


