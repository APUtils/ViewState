//
//  AnimateIfNeeded.swift
//  Pods
//
//  Created by Anton Plebanovich on 22.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import RxSwift
import UIKit
#if SPM
import ViewState
#endif

public extension Reactive where Base: UIView {
    
    /// Perform changes animated if `view` is animatable, `animate` is `true`, and `duration` more than 0.
    /// Just perform changes otherwise.
    static func animateIfNeeded(
        in view: UIView,
        animated: Bool = true,
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        scrollView: UIScrollView? = nil,
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateIfNeeded(
                in: view,
                animated: animated,
                layout: layout,
                duration: duration,
                delay: delay,
                options: options,
                scrollView: scrollView,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    /// Perform changes animated if `base` is animatable, `animate` is `true`, and `duration` more than 0.
    func animateIfNeeded(
        animated: Bool = true,
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        scrollView: UIScrollView? = nil,
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateIfNeeded(
                in: base,
                animated: animated,
                layout: layout,
                duration: duration,
                delay: delay,
                options: options,
                scrollView: scrollView,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    /// Perform changes animated if `view` is animatable, `animate` is `true`, and `duration` more than 0.
    static func animateTransitionIfNeeded(
        in view: UIView,
        animated: Bool = true,
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        scrollView: UIScrollView? = nil,
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateTransitionIfNeeded(
                in: view,
                animated: animated,
                duration: duration,
                delay: delay,
                options: options,
                scrollView: scrollView,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    /// Perform changes animated if `base` is animatable, `animate` is `true`, and `duration` more than 0.
    func animateTransitionIfNeeded(
        animated: Bool = true,
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        scrollView: UIScrollView? = nil,
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateTransitionIfNeeded(
                in: base,
                animated: animated,
                layout: layout,
                duration: duration,
                delay: delay,
                options: options,
                scrollView: scrollView,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
}
