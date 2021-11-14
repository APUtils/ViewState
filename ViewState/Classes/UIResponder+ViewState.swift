//
//  UIResponder+ViewState.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 2/19/18.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit
import RoutableLogger

private var c_becomeMainResponderAssociationKey = 0
private var c_becomeFirstResponderWhenPossibleAssociationKey = 0
private var c_becomeFirstResponderOnViewDidAppearAssociationKey = 0

public extension UIResponder {
    private var _viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
    
    private var _becomeMainResponder: Bool {
        get {
            return objc_getAssociatedObject(self, &c_becomeMainResponderAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_becomeMainResponderAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var _becomeFirstResponderWhenPossible: Bool {
        get {
            return objc_getAssociatedObject(self, &c_becomeFirstResponderWhenPossibleAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_becomeFirstResponderWhenPossibleAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var _becomeFirstResponderOnViewDidAppear: Bool {
        get {
            return objc_getAssociatedObject(self, &c_becomeFirstResponderOnViewDidAppearAssociationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &c_becomeFirstResponderOnViewDidAppearAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // TODO: Become first responder on container controller become first responder (e.g. navigation or tab bar if child controller is main).
    /// Tells responder to become main responder. It means it'll become first when view has window and will try to restore it's state on willAppear/didAppear.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    @IBInspectable var becomeMainRespoder: Bool {
        get {
            return _becomeMainResponder
        }
        set {
            guard newValue != _becomeMainResponder else { return }
            
            _becomeMainResponder = newValue
            
            if newValue {
                let vc = _viewController
                if vc?.viewState == .didAttach || vc?.viewState == .didAppear {
                    // Already appeared
                    becomeFirstResponder()
                    RoutableLogger.logVerbose("Becoming main responder for: \(self)")
                    
                } else {
                    // Wait until appeared
                    var stateDidChangedToken: NSObjectProtocol! = nil
                    let handleNotification: (Notification) -> Void = { [weak self] notification in
                        guard let _self = self, _self._becomeMainResponder else {
                            // Object no longer exists or no longer notification no longer needed.
                            // Remove observer.
                            if let stateDidChangedToken = stateDidChangedToken { NotificationCenter.default.removeObserver(stateDidChangedToken) }
                            return
                        }
                        // Assure notification for proper controller
                        guard _self._viewController == notification.object as? UIViewController else { return }
                        
                        // Assure view is loaded and has window
                        guard _self._viewController?.isViewLoaded == true
                                && _self._viewController?.view.window != nil else { return }
                        
                        // Assure it's appear notification
                        guard let viewState: UIViewController.ViewState = notification.userInfo?["viewState"] as? UIViewController.ViewState else { return }
                        
                        guard viewState == UIViewController.ViewState.didAttach
                                || viewState == UIViewController.ViewState.willAppear
                                || viewState == UIViewController.ViewState.didAppear else { return }
                        
                        RoutableLogger.logVerbose("Becoming main responder for: \(_self)")
                        _self.becomeFirstResponder()
                    }
                    stateDidChangedToken = NotificationCenter.default.addObserver(forName: .UIViewControllerViewStateDidChange, object: vc, queue: nil, using: handleNotification)
                }
            } else {
                
            }
        }
    }
    
    /// Tells responder to become first when view has window.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    @IBInspectable var becomeFirstResponderWhenPossible: Bool {
        get {
            return _becomeFirstResponderWhenPossible
        }
        set {
            guard newValue != _becomeFirstResponderWhenPossible else { return }
            
            _becomeFirstResponderWhenPossible = newValue
            
            if newValue {
                let vc: UIViewController? = _viewController
                if vc?.viewState == UIViewController.ViewState.didAttach
                    || vc?.viewState == UIViewController.ViewState.didAppear {
                    
                    // Already appeared
                    _becomeFirstResponderWhenPossible = false
                    becomeFirstResponder()
                    RoutableLogger.logVerbose("Becoming first responder possible for: \(self)")
                    
                } else {
                    // Wait until appeared
                    var stateDidChangedToken: NSObjectProtocol! = nil
                    let handleNotification: (Notification) -> Void = { [weak self] notification in
                        guard let _self = self, _self._becomeFirstResponderWhenPossible else {
                            // Object no longer exists or no longer notification no longer needed.
                            // Remove observer.
                            if let stateDidChangedToken = stateDidChangedToken { NotificationCenter.default.removeObserver(stateDidChangedToken) }
                            return
                        }
                        // Assure notification for proper controller
                        guard _self._viewController == notification.object as? UIViewController else { return }
                        // Assure view is loaded and has window
                        guard _self._viewController?.isViewLoaded == true && _self._viewController?.view.window != nil else { return }
                        
                        // Got our notification. Remove observer.
                        if let stateDidChangedToken = stateDidChangedToken { NotificationCenter.default.removeObserver(stateDidChangedToken) }
                        
                        // Reset this flag so we can assign it again later if needed
                        _self._becomeFirstResponderWhenPossible = false
                        
                        _self.becomeFirstResponder()
                        RoutableLogger.logVerbose("Becoming first responder possible for: \(_self)")
                    }
                    stateDidChangedToken = NotificationCenter.default.addObserver(forName: .UIViewControllerViewStateDidChange, object: vc, queue: nil, using: handleNotification)
                }
            } else {
                
            }
        }
    }
    
    /// Tells responder to become first only after view did appear.
    ///
    /// Quote from Apple doc: "Never call this method on a view that is not part of an active view hierarchy. You can determine whether the view is onscreen, by checking its window property. If that property contains a valid window, it is part of an active view hierarchy. If that property is nil, the view is not part of a valid view hierarchy."
    ///
    /// Because configuration usually is made in `viewDidLoad` or `viewWillAppear` while `view` still might have `nil` `window` it's useful to delay `becomeFirstResponder` calls.
    @IBInspectable var becomeFirstResponderOnViewDidAppear: Bool {
        get {
            return _becomeFirstResponderOnViewDidAppear
        }
        set {
            guard newValue != becomeFirstResponderOnViewDidAppear else { return }
            
            _becomeFirstResponderOnViewDidAppear = newValue
            
            if newValue {
                let vc: UIViewController? = _viewController
                if vc?.viewState == UIViewController.ViewState.didAppear {
                    // Already appeared
                    _becomeFirstResponderOnViewDidAppear = false
                    RoutableLogger.logVerbose("Becoming first responder on view did appear for: \(self)")
                    becomeFirstResponder()
                    
                } else {
                    // Wait until appeared
                    var token: NSObjectProtocol!
                    token = NotificationCenter.default.addObserver(forName: .UIViewControllerViewDidAppear, object: vc, queue: nil) { [weak self] notification in
                        guard let _self = self, _self._becomeFirstResponderOnViewDidAppear else {
                            // Object no longer exists or no longer notification no longer needed.
                            // Remove observer.
                            if let token = token { NotificationCenter.default.removeObserver(token) }
                            return
                        }
                        // Assure notification for proper controller
                        guard _self._viewController == notification.object as? UIViewController else { return }
                        
                        // Got our notification. Remove observer.
                        if let token = token { NotificationCenter.default.removeObserver(token) }
                        
                        // Reset this flag so we can assign it again later if needed
                        _self._becomeFirstResponderOnViewDidAppear = false
                        RoutableLogger.logVerbose("Becoming first responder on view did appear for: \(_self)")
                        _self.becomeFirstResponder()
                    }
                }
            } else {
                
            }
        }
    }
}
