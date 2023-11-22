//
//  ObservableType+ViewState.swift
//  Pods
//
//  Created by Anton Plebanovich on 22.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    /// Prepends and evaluates element expression to an observable sequence on subscription.
    /// Do not emit anything if element expression evaluates to `nil`.
    /// - seealso: [startWith operator on reactivex.io](http://reactivex.io/documentation/operators/startwith.html)
    /// - parameter element: Element to prepend to the specified sequence on subscription or `nil`.
    /// - returns: The source sequence prepended with the specified element if it is not `nil`.
    func _startWithDeferred(_ element: @escaping () -> Element?) -> Observable<Element> {
        return Observable.create {
            if let element = element() {
                return self
                    .startWith(element)
                    .subscribe($0)
            } else {
                return self
                    .subscribe($0)
            }
        }
    }
}
