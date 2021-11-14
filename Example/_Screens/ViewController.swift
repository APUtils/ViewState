//
//  ViewController.swift
//  PROJECTNAME-Example
//
//  Created by Anton Plebanovich on 4/12/19.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Animatable viewDidLoad: \(view.isAnimatable)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Animatable viewWillAppear: \(view.isAnimatable)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Animatable viewDidAppear: \(view.isAnimatable)")
    }
    
    // ******************************* MARK: - Actions
    
    @IBAction private func onTableViewReloadTap(_ sender: Any) {
        let vc = UIStoryboard(name: "TableViewReload", bundle: nil).instantiateInitialViewController() as! TableViewReloadVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
