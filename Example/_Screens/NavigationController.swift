//
//  NavigationController.swift
//  ViewState
//
//  Created by Anton Plebanovich on 1/3/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        modalPresentationStyle = .fullScreen
    }
}
