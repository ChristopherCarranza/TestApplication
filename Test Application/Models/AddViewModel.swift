//
//  AddViewModel.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

final class AddViewModel {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func addUser(name: String) {
        let user = User(name: name, source: .local)
        userRepository.add(model: user)
    }
}
