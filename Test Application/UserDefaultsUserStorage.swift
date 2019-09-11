//
//  UserDefaultsUserStorage.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation

public class UserDefaultsUserStorage: PersistantStorage {
    
    private let userDefaults: UserDefaults
    
    private let key: String = "users"
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func values() throws -> [Any] {
        return decodedObjects()
    }
    
    func addValue(value: Any) throws {
        var tempValues = decodedObjects()
        tempValues.append(value as! User)
        
        saveObjects(values: tempValues)
    }
    
    func removeValue(value: Any) throws {
        guard let user = value as? User else { return }
        var tempValues = decodedObjects()
        tempValues.removeAll(where: { $0 == user })
        
        saveObjects(values: tempValues)
    }
    
    func addValues(values: [Any]) throws {
        var tempValues = decodedObjects()
        tempValues.append(contentsOf: values as! [User])
        
        saveObjects(values: tempValues)
    }
    
    func removeValues(values: [Any]) throws {
        guard let users = values as? [User] else { return }
        var tempValues = decodedObjects()
        tempValues.removeAll(where: { users.contains($0) })
        
        saveObjects(values: tempValues)
    }
    
    private func saveObjects(values: [Any]) {
        guard let users = values as? [User] else { return }
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(users) else { return }
        
        userDefaults.set(data, forKey: key)
    }
    
    private func decodedObjects() -> [User] {
        guard let data = userDefaults.object(forKey: key) as? Data else { return [] }
        let decoder = JSONDecoder()
        guard let users = try? decoder.decode([User].self, from: data) else { return [] }
        return users
    }
}
