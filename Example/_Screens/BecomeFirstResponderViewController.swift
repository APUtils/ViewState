//
//  BecomeFirstResponderViewController.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/22/18.
//  Copyright © 2019 Anton Plebanovich All rights reserved.
//

import UIKit
import ViewState

final class BecomeFirstResponderViewController: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private weak var textField: UITextField!
    
    // ******************************* MARK: - Private Properties
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        setup()
        
        super.viewDidLoad()
    }
    
    private func setup() {
        navigationController?.modalPresentationStyle = .fullScreen
    }
    
    // ******************************* MARK: - Configuration
    
    private func configure() {
        textField.becomeFirstResponderWhenPossible = true
    }
    
    // ******************************* MARK: - UIViewController Overrides

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configure()
    }
    
    // ******************************* MARK: - Actions
    
    // ******************************* MARK: - Notifications
}
