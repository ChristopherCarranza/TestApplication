//
//  MainViewModel.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UITableViewPresentation
import RxSwift
import RxRelay
import Fakery

final class MainViewModel {
    
    private let bag = DisposeBag()
    private let userRepository: UserRepository
    private var dataSource: UITableViewPresentableDataSource!
    
    private let loading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func viewDidLoad(tableView: UITableView) {
        dataSource = UITableViewPresentableDataSource(tableView: tableView, delegate: nil, tableViewModel: mapUserToModel(userRepository.currentModels, loading: false))
        dataSource.insertionAnimation = .fade
        dataSource.deletionAnimation = .fade
        
        Observable
            // This observable listens for changes of both the model and the loading state.
            // If either changes it will emit with the latest value of both.
            .combineLatest(userRepository.models, loading.asObservable())
            .subscribe(onNext: { users, loading in
                let model = self.mapUserToModel(users, loading: loading)
                self.dataSource.setTableViewModel(to: model, animated: true)
            })
            .disposed(by: bag)
    }
    
    func getUsersFromNetwork() {
        loading.accept(true)
        
        let faker = Faker(locale: "en-US")
        
        Observable
            .of([User(name: faker.name.name(), source: .network), User(name: faker.name.name(), source: .network)])
            .delay(.seconds(2), scheduler: MainScheduler.instance)
            .asSingle()
            .subscribe(onSuccess: { [unowned self] users in
                self.userRepository.add(models: users)
                self.loading.accept(false)
            })
            .disposed(by: bag)
    }
    
    /// Translates our users into their presentation for the tableview. We rebuild the presentation layer from scratch everytime.
    ///
    /// - Parameters:
    ///   - users: users
    ///   - loading: loading
    /// - Returns: a UITableViewModel for the tableview datasource
    private func mapUserToModel(_ users: [User], loading: Bool) -> UITableViewModel {
        var sections: [UITableViewSection] = []
        
        let networkUsers = users.filter { $0.source == .network }
        if !networkUsers.isEmpty {
            sections.append(UITableViewSection(rows: networkUsers.map { UserPresenter(user: $0, delegate: self) }, header: .title("Network Users"), footer: .blank))
        }
        
        let localUsers = users.filter { $0.source == .local }
        if !localUsers.isEmpty {
            sections.append(UITableViewSection(rows: localUsers.map { UserPresenter(user: $0, delegate: self) }, header: .title("Local Users"), footer: .blank))
        }
        
        if loading {
            sections.append(
                UITableViewSection(rows: [LoadingPresenter()], footer: .blank)
            )
        }
        
        return UITableViewModel(sections: sections)
    }
}

extension MainViewModel: UserPresenterDelegate {
    func deleteActionPerformed(presenter: UserPresenter) {
        userRepository.remove(model: presenter.user)
    }
}
