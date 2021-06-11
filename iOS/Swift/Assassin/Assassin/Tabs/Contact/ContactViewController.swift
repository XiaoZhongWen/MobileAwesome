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

class ContactViewController: ViewController {
    private let tableView = UITableView.init()
    private let datasource = PublishSubject<[SectionOfContactModel]>()
    var ds:RxTableViewSectionedReloadDataSource<SectionOfContactModel>?
}

extension ContactViewController {
    // life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.identifier)
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { maker in
            maker.edges.equalTo(self.view)
        }

        self.loadData()
        self.bindVM()

        let btn = UIButton.init(type: .contactAdd)
        self.view.addSubview(btn)

        btn.snp_makeConstraints { make in
            make.center.equalTo(self.view)
        }

        btn.rx.tap.subscribe(onNext:  {
            let c = ContactModel.init()
            c.depts = "1"
            c.nickname = "2"
            c.username = "3"
            let indexPath = IndexPath.init(row: 0, section: 0)
            self.ds?[indexPath] = c
//            let d = SectionOfContactModel.init(header: "*", items: [c])
        }).disposed(by: disposeBag)

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
                    self.datasource.onNext(sections)
                }
                break
            case .failure(_):
                break
            }
        }).disposed(by: self.disposeBag)
    }

    func bindVM() {
        let ds = RxTableViewSectionedReloadDataSource<SectionOfContactModel> { (datasource, tableView, indexPath, item) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath)
            return cell
        }
        ds.titleForHeaderInSection = { datasource, index in
            return ds.sectionModels[index].header
        }
        self.datasource.bind(to: tableView.rx.items(dataSource: ds)).disposed(by: disposeBag)
        self.ds = ds
    }
}
