//
//  MainViewModelFactory.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

final class MainViewModelFactory {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func create() -> MainViewModel {
        return MainViewModel(userRepository: userRepository)
    }
}
