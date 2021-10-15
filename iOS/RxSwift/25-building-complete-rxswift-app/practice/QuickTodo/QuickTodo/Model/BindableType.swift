//
//  BindableType.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/14.
//

import UIKit

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    var viewModel:ViewModelType! {get set}
    func bindViewModel()
}

extension BindableType where Self:UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
//        loadViewIfNeeded()
        bindViewModel()
    }
}
