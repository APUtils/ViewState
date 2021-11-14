//
//  UIView+ViewState.swift
//  ViewState
//
//  Created by Anton Plebanovich on 14.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Returns `true` if view can be animated.
    /// That means `window` is not `nil` and application state is `.active`.
    var isAnimatable: Bool {
        var isAnimatable = window != nil && UIApplication.shared.applicationState != .background
        
        if let viewState = _viewController?.viewState {
            isAnimatable = isAnimatable && viewState == .didAppear
        }
        
        return isAnimatable
    }
}
