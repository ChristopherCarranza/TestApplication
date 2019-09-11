//
//  LoadingPresenter.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import Foundation
import UITableViewPresentation

final class LoadingPresenter: UITableViewPresentable {
    
    init() {}

    func configure(cell: LoadingTableViewCell, at indexPath: IndexPath) {
        cell.activityIndicator.startAnimating()
    }
    
    static func == (lhs: LoadingPresenter, rhs: LoadingPresenter) -> Bool {
        return true
    }
}

extension LoadingPresenter: UITableViewNibRegistrable {}
