//
//  TasksViewController.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import UIKit
import RxDataSources

class TasksViewController:UIViewController, BindableType {
    typealias ViewModelType = TasksViewModel
    var viewModel: TasksViewModel!
    func bindViewModel() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        SectionModel
        AnimatableSectionModel

    }
}