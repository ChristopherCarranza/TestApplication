//
//  UserPresenter.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UITableViewPresentation

protocol UserPresenterDelegate: class {
    func deleteActionPerformed(presenter: UserPresenter)
}

final class UserPresenter: UITableViewPresentable {

    let user: User
    
    weak var delegate: UserPresenterDelegate?
    
    init(user: User, delegate: UserPresenterDelegate? = nil) {
        self.user = user
        self.delegate = delegate
    }
    
    func configure(cell: UserTableViewCell, at indexPath: IndexPath) {
        cell.nameLabel.text = user.name
    }
    
    static func == (lhs: UserPresenter, rhs: UserPresenter) -> Bool {
        return lhs.user == rhs.user
    }
}

extension UserPresenter: UITableViewNibRegistrable {}

extension UserPresenter: UITableViewSwipableRow {
    func leadingSwipeActionsConfiguration() -> UISwipeActionsConfiguration? {
        return nil
    }
    
    func trailingSwipeActionsConfiguration() -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] (_, _, completion) in
                guard let self = self else {
                    completion(false)
                    return
                }
                self.delegate?.deleteActionPerformed(presenter: self)
                completion(true)
            })
        ])
    }
    
    
}
