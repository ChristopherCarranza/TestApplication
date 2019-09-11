//
//  Repository.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class Repository<Model: Hashable> {
    
    private let storage: PersistantStorage
    private let _models: BehaviorRelay<[Model]>
    var currentModels: [Model] {
        return _models.value
    }
    var models: Observable<[Model]> {
        return _models
            .asObservable()
            // This will only emit if the contents are equatably different
            .distinctUntilChanged()
            // This will cause multiple subscriptions to share the same underlying value
            .share()
    }
    
    init(storage: PersistantStorage) {
        self.storage = storage
        _models = BehaviorRelay(value: try! storage.values() as! [Model])
    }
    
    func add(models: [Model]) {
        var tempModels = _models.value
        tempModels.append(contentsOf: models)
        
        try! storage.addValues(values: models)
        _models.accept(tempModels)
    }
    
    func add(model: Model) {
        var tempModels = _models.value
        tempModels.append(model)
        
        try! storage.addValue(value: model)
        _models.accept(tempModels)
    }
    
    func remove(model: Model) {
        var tempModels = _models.value
        guard let index = tempModels.firstIndex(of: model) else { return }
        tempModels.remove(at: index)
        
        try! storage.removeValue(value: model)
        _models.accept(tempModels)
    }
}
