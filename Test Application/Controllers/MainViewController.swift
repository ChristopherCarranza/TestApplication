//
//  MainViewController.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit
import UITableViewPresentation

final class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: MainViewModel
    private let addViewControllerFactory: AddViewControllerFactory
    
    init(viewModel: MainViewModel, addViewControllerFactory: AddViewControllerFactory) {
        self.viewModel = viewModel
        self.addViewControllerFactory = addViewControllerFactory
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad(tableView: tableView)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped(_ sender: UIBarButtonItem) {
        let controller = addViewControllerFactory.create()
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func getFromNetworkButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.getUsersFromNetwork()
    }
}
