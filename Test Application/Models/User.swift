//
//  User.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/10/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

struct User: Hashable, Codable {
    enum Source: String, Hashable, Codable {
        case network
        case local
    }
    
    var name: String
    var source: Source
    
    init(name: String, source: Source) {
        self.name = name
        self.source = source
    }
}
