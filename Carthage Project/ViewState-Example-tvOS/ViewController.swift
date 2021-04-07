//
//  ViewController.swift
//  ViewState-Example-tvOS
//
//  Created by Anton Plebanovich on 4/7/21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import ViewState
import UIKit

class ViewController: UIViewController, ViewControllerExtendedStates {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func viewDidAttach() {
        print("viewDidAttach")
    }
}
