//
//  ContactViewController.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/3.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class ContactViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView = UITableView.init()
    private var datasource:[ContactModel] = []
}

extension ContactViewController {
    // life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { maker in
            maker.edges.equalTo(self.view)
        }

        self.loadData()
    }
}

extension ContactViewController {
    // delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
        return cell
    }
}

extension ContactViewController {
    // private methods
    func loadData() {
        ContactService.shared.fetchContactList().emit(onNext: { state in
            switch state {
            case .requesting:
                break
            case let .success(response):
                if let contacts = response {
                    var sections:[SectionOfContactModel] = []
                    var map:[String:[ContactModel]] = Dictionary.init()
                    for contact in contacts {
                        var firstLetter = "#"
                        if let nickname = contact.nickname {
                            firstLetter = HTFirstLetter.firstLetter(nickname)
                        }
                        if let array = map[firstLetter] {
                            var arr = array
                            arr.append(contact)
                            map[firstLetter] = arr
                        } else {
                            map[firstLetter] = [contact]
                        }
                    }
                    for (header, contacts) in map {
                        let section = SectionOfContactModel.init(header: header, items: contacts)
                        sections.append(section)
                    }
                }
                break
            case .failure(_):
                break
            }
        }).disposed(by: self.disposeBag)
    }
}
