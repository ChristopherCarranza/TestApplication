//
//  AddViewControllerFactory.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

final class AddViewControllerFactory {
    
    let viewModelFactory: AddViewModelFactory
    
    init(viewModelFactory: AddViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func create() -> UIViewController {
        return AddViewController(viewModel: viewModelFactory.create())
    }
    
}
