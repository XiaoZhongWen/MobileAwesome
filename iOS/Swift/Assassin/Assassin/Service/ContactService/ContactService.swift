//
//  ContactService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/4.
//

import Foundation
import RxSwift
import RxCocoa

class ContactService {

    static let shared = ContactService.init()
    private init() {}

    func fetchContactList(offset: Int = 0, limit: Int = 20) -> Signal<RequestState<[ContactModel]>> {
        return Observable.create { observer in
            observer.onNext(.requesting)
            DispatchQueue.serviceQueue.async {
                let contacts = ContactDao.init().fetchContacts(offset: offset, limit: limit)
                var models:[ContactModel] = []
                for item in contacts {
                    if let m = ContactModel.deserialize(from: item) {
                        models.append(m)
                    }
                }
                observer.onNext(.success(models))
            }
            return Disposables.create()
        }.asSignal(onErrorJustReturn: .failure("fetch contact list fail!"))
    }
}
