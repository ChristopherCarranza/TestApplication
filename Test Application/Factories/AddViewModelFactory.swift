//
//  AddViewModelFactory.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

final class AddViewModelFactory {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func create() -> AddViewModel {
        return AddViewModel(userRepository: userRepository)
    }
}
