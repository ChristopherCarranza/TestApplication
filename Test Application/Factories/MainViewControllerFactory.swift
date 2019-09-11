//
//  MainViewControllerFactory.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

final class MainViewControllerFactory {
    
    private let viewModelFactory: MainViewModelFactory
    private let addViewControllerFactory: AddViewControllerFactory
    
    init(viewModelFactory: MainViewModelFactory, addViewControllerFactory: AddViewControllerFactory) {
        self.viewModelFactory = viewModelFactory
        self.addViewControllerFactory = addViewControllerFactory
    }
    
    func create() -> UIViewController {
        return MainViewController(viewModel: viewModelFactory.create(), addViewControllerFactory: addViewControllerFactory)
    }
}
