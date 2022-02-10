//
//  UIView+ViewState.swift
//  ViewState
//
//  Created by Anton Plebanovich on 14.11.21.
//  Copyright © 2021 Anton Plebanovich. All rights reserved.
//

import Foundation
import UIKit
import RoutableLogger

public extension UIView {
    
    /// Returns `true` if view can be animated.
    /// That means `window` is not `nil` and application state is `.active`.
    var isAnimatable: Bool {
        var isAnimatable = window != nil
        && UIApplication.shared.applicationState != .background
        && UIView.areAnimationsEnabled
        
        // No sense to animate anything if view is not in a view hierarchy yet
        if isAnimatable, let vc = _viewController {
            isAnimatable = vc.viewState == .didAttach || vc.viewState == .didAppear
        }
        
        return isAnimatable
    }
    
    // ******************************* MARK: - Animate
    
    /// Perform changes animated if receiver is animatable and `duration` more than 0.
    /// Just perform changes otherwise.
    func animateIfNeeded(layout: Bool = true,
                         duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                         delay: TimeInterval = 0,
                         options: UIView.AnimationOptions = [],
                         animations: @escaping () -> Void,
                         completion: ((Bool) -> Void)? = nil,
                         file: String = #file,
                         function: String = #function,
                         line: UInt = #line) {
        
        Self.animateIfNeeded(view: self,
                             layout: layout,
                             duration: duration,
                             delay: delay,
                             options: options,
                             animations: animations,
                             completion: completion,
                             file: file,
                             function: function,
                             line: line)
    }
    
    /// Perform changes animated if `view` is animatable and `duration` more than 0.
    /// Just perform changes otherwise.
    static func animateIfNeeded(view: UIView,
                                layout: Bool = true,
                                duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                delay: TimeInterval = 0,
                                options: UIView.AnimationOptions = [],
                                animations: @escaping () -> Void,
                                completion: ((Bool) -> Void)? = nil,
                                file: String = #file,
                                function: String = #function,
                                line: UInt = #line) {
        
        let animated = view.isAnimatable && duration > 0
        
        let animate: () -> Void = {
            let date = Date()
            animations()
            let computationTime = Date().timeIntervalSince(date)
            
            RoutableLogger.logVerbose("Animaitons computation time: \(computationTime)")
            if computationTime > 1 {
                RoutableLogger.logErrorOnce("Huge animations computation time", data: ["computationTime": computationTime], file: file, function: function, line: line)
            }
        }
        
        if animated {
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                animate()
                
                if layout {
                    view.layoutIfNeeded()
                }
                
            }, completion: completion)
            
        } else {
            animate()
            completion?(true)
        }
    }
    
    // ******************************* MARK: - Transition
    
    func animateTransitionIfNeeded(layout: Bool = true,
                                   duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                   delay: TimeInterval = 0,
                                   options: UIView.AnimationOptions = [],
                                   animations: @escaping () -> Void,
                                   completion: ((Bool) -> Void)? = nil,
                                   file: String = #file,
                                   function: String = #function,
                                   line: UInt = #line) {
        
        Self.animateTransitionIfNeeded(view: self,
                                       layout: layout,
                                       duration: duration,
                                       delay: delay,
                                       options: options,
                                       animations: animations,
                                       completion: completion,
                                       file: file,
                                       function: function,
                                       line: line)
    }
    
    static func animateTransitionIfNeeded(view: UIView,
                                          layout: Bool = true,
                                          duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                          delay: TimeInterval = 0,
                                          options: UIView.AnimationOptions = [],
                                          animations: @escaping () -> Void,
                                          completion: ((Bool) -> Void)? = nil,
                                          file: String = #file,
                                          function: String = #function,
                                          line: UInt = #line) {
        
        let animated = view.isAnimatable && duration > 0
        
        let animate: () -> Void = {
            let date = Date()
            animations()
            let computationTime = Date().timeIntervalSince(date)
            
            RoutableLogger.logVerbose("Transition animaitons computation time: \(computationTime)")
            if computationTime > 1 {
                RoutableLogger.logErrorOnce("Huge transition animations computation time", data: ["computationTime": computationTime], file: file, function: function, line: line)
            }
        }
        
        if animated {
            UIView.transition(with: view, duration: duration, options: options, animations: {
                UIView.performWithoutAnimation {
                    animate()
                    
                    if layout {
                        view.layoutIfNeeded()
                    }
                }
                
            }, completion: completion)
            
        } else {
            animate()
            completion?(true)
        }
    }
}

// ******************************* MARK: - Constants

public extension UIView {
    enum ViewStateConstants {}
}

public extension UIView.ViewStateConstants {
    static var defaultAnimationDuration: TimeInterval = 0.3
}
