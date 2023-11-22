//
//  SubscribeOnVisible.swift
//  Pods
//
//  Created by Anton Plebanovich on 22.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    
    /// Stops events processing when screen disappearing and resumes on appearing.
    func subscribeOnVisible(vc: UIViewController) -> Driver<Element> {
        vc.rx.viewState
            .map { $0 != .didDetach }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .flatMapLatest { visible in
                if visible {
                    return asDriver()
                } else {
                    return .empty()
                }
            }
    }
}

public extension ObservableConvertibleType {
    
    /// Stops events processing when screen disappearing and resumes on appearing.
    func subscribeOnVisible(vc: UIViewController) -> Observable<Element> {
        vc.rx.viewState
            .map { $0 != .didDetach }
            .distinctUntilChanged()
            .flatMapLatest { visible in
                if visible {
                    return asObservable()
                } else {
                    return .empty()
                }
            }
    }
}
