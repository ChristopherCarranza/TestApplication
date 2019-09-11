//
//  AddViewController.swift
//  Test Application
//
//  Created by Christopher Carranza on 9/11/19.
//  Copyright © 2019 Christopher Carranza. All rights reserved.
//

import UIKit

final class AddViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    private let viewModel: AddViewModel
    
    init(viewModel: AddViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addUserTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            dismiss(animated: true, completion: nil)
            return
        }
        viewModel.addUser(name: name)
        dismiss(animated: true, completion: nil)
    }
}
