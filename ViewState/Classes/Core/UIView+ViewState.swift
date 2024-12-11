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
            isAnimatable = vc.viewState == .didAttach
            || vc.viewState == .didAppear
            || vc.viewState == .willDisappear
            // We animate if view disappear but is still attached because it might be visible underneath
            || vc.viewState == .didDisappear
        }
        
        return isAnimatable
    }
    
    // ******************************* MARK: - Animate
    
    /// Perform changes animated if `self` is animatable, `animate` is `true`, and `duration` more than 0.
    /// Just perform changes otherwise.
    func animateIfNeeded(animated: Bool = true,
                         layout: Bool = true,
                         duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                         delay: TimeInterval = 0,
                         options: UIView.AnimationOptions = [],
                         animations: @escaping () -> Void,
                         completion: ((Bool) -> Void)? = nil,
                         file: String = #file,
                         function: String = #function,
                         line: UInt = #line) {
        
        Self.animateIfNeeded(in: self,
                             animated: animated,
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
    
    /// Perform changes animated if `view` is animatable, `animate` is `true`, and `duration` more than 0.
    /// Just perform changes otherwise.
    static func animateIfNeeded(in view: UIView,
                                animated: Bool = true,
                                layout: Bool = true,
                                duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                delay: TimeInterval = 0,
                                options: UIView.AnimationOptions = [],
                                animations: @escaping () -> Void,
                                completion: ((Bool) -> Void)? = nil,
                                file: String = #file,
                                function: String = #function,
                                line: UInt = #line) {
        
        let animated = animated && view.isAnimatable && duration > 0
        
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
                if layout { view.layoutIfNeeded() }
                
            }, completion: completion)
            
        } else {
            animate()
            if layout { view.layoutIfNeeded() }
            completion?(true)
        }
    }
    
    // ******************************* MARK: - Transition
    
    /// Perform changes animated if `self` is animatable, `animate` is `true`, and `duration` more than 0.
    func animateTransitionIfNeeded(animated: Bool = true,
                                   layout: Bool = true,
                                   duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                   delay: TimeInterval = 0,
                                   options: UIView.AnimationOptions = [],
                                   animations: @escaping () -> Void,
                                   completion: ((Bool) -> Void)? = nil,
                                   file: String = #file,
                                   function: String = #function,
                                   line: UInt = #line) {
        
        Self.animateTransitionIfNeeded(in: self,
                                       animated: animated,
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
    
    /// Perform changes animated if `view` is animatable, `animate` is `true`, and `duration` more than 0.
    static func animateTransitionIfNeeded(in view: UIView,
                                          animated: Bool = true,
                                          layout: Bool = true,
                                          duration: TimeInterval = ViewStateConstants.defaultAnimationDuration,
                                          delay: TimeInterval = 0,
                                          options: UIView.AnimationOptions = [],
                                          animations: @escaping () -> Void,
                                          completion: ((Bool) -> Void)? = nil,
                                          file: String = #file,
                                          function: String = #function,
                                          line: UInt = #line) {
        
        let animated = animated && view.isAnimatable && duration > 0
        
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
                    if layout { view.layoutIfNeeded() }
                }
                
            }, completion: completion)
            
        } else {
            animate()
            if layout { view.layoutIfNeeded() }
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
