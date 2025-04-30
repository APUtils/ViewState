//
//  SubscribeOnVisible.swift
//  Pods
//
//  Created by Anton Plebanovich on 22.11.23.
//  Copyright © 2023 Anton Plebanovich. All rights reserved.
//

import RoutableLogger
import RxCocoa
import RxSwift
import UIKit

public extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {
    
    /// Stops events processing when screen disappearing and resumes on appearing.
    func subscribeOnVisible(vc: UIViewController, file: String = #file, function: String = #function, line: UInt = #line) -> Driver<Element> {
        vc.rx.viewState
            .map { $0 != .didDetach }
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .flatMapLatest { visible in
                if visible {
                    RoutableLogger.logVerbose("Activating \(file._fileName):\(line) subscription", file: file, function: function, line: line)
                    return asDriver()
                } else {
                    RoutableLogger.logVerbose("Deactivating \(file._fileName):\(line) subscription", file: file, function: function, line: line)
                    return .empty()
                }
            }
    }
}

public extension ObservableConvertibleType {
    
    /// Stops events processing when screen disappearing and resumes on appearing.
    func subscribeOnVisible(vc: UIViewController, file: String = #file, function: String = #function, line: UInt = #line) -> Observable<Element> {
        vc.rx.viewState
            .map { $0 != .didDetach }
            .distinctUntilChanged()
            .flatMapLatest { visible in
                if visible {
                    RoutableLogger.logVerbose("Activating \(file._fileName):\(line) subscription", file: file, function: function, line: line)
                    return asObservable()
                } else {
                    RoutableLogger.logVerbose("Deactivating \(file._fileName):\(line) subscription", file: file, function: function, line: line)
                    return .empty()
                }
            }
    }
}
