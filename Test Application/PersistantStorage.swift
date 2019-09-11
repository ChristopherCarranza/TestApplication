//
//  PersistantStorage.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

protocol PersistantStorage {
    func values() throws -> [Any]
    func addValue(value: Any) throws
    func removeValue(value: Any) throws
    func addValues(values: [Any]) throws
    func removeValues(values: [Any]) throws
}
