//
//  ViewState+RxSwift.swift
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

// ******************************* MARK: - UIViewController

public extension Reactive where Base: UIViewController {
    
    /// Reactive wrapper for `viewState` property. Returns current state on subscription.
    var viewState: Observable<UIViewController.ViewState> {
        NotificationCenter.default.rx.notification(.UIViewControllerViewStateDidChange, object: base)
            .compactMap { notification in notification.userInfo?["viewState"] as? Base.ViewState }
        // Reentrancy anomaly fix
            .observe(on: MainScheduler.instance)
            ._startWithDeferred { [weak base] in base?.viewState }
            .distinctUntilChanged()
    }
}
