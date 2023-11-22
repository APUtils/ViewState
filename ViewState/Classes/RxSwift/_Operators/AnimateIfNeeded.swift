//
//  AnimateIfNeeded.swift
//  Pods
//
//  Created by Anton Plebanovich on 22.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import RxSwift
import UIKit

public extension Reactive where Base: UIView {
    
    /// Perform changes animated if `view` is animatable and `duration` more than 0.
    /// Just perform changes otherwise.
    static func animateIfNeeded(
        view: UIView,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateIfNeeded(
                view: view,
                duration: duration,
                delay: delay,
                options: options,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    func animateIfNeeded(
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateIfNeeded(
                view: base,
                layout: layout,
                duration: duration,
                delay: delay,
                options: options,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    static func animateTransitionIfNeeded(
        view: UIView,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateTransitionIfNeeded(
                view: view,
                duration: duration,
                delay: delay,
                options: options,
                animations: animations,
                completion: { finish(.success($0)) },
                file: file,
                function: function,
                line: line
            )
            
            return Disposables.create()
        }
    }
    
    func animateTransitionIfNeeded(
        layout: Bool = true,
        duration: TimeInterval = UIView.ViewStateConstants.defaultAnimationDuration,
        delay: TimeInterval = 0,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) -> Single<Bool> {
        
        Single<Bool>.create { finish in
            UIView.animateTransitionIfNeeded(
                view: base,
                layout: layout,
                duration: duration,
                delay: delay,
                options: options,
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
