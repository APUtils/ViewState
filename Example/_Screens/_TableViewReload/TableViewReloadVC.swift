//
//  TableViewReloadVC.swift
//  ViewState
//
//  Created by Anton Plebanovich on 1/3/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import APExtensions
import UIKit
import ViewState

final class TableViewReloadVC: UIViewController {
    
    // ******************************* MARK: - @IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // ******************************* MARK: - Initialization and Setup
    
    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    private func setup() {
        tableView.reloadDataWhenPossible()
        tableView.reloadDataWhenPossible()
    }
    
    // ******************************* MARK: - UIViewController Overrides
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadDataWhenPossible()
        
        doOnce(key: "TableViewReloadVC.viewDidAppear") {
            let vc = UIViewController()
            vc.view.backgroundColor = .white
            navigationController?.pushViewController(vc)
            
            g.asyncMain(1) {
                // Console warning
                // 2020-01-03 12:23:36.800230+0300 Example[44329:2932176] [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window). This may cause bugs by forcing views inside the table view to load and perform layout without accurate information (e.g. table view bounds, trait collection, layout margins, safe area insets, etc), and will also cause unnecessary performance overhead due to extra layout passes. Make a symbolic breakpoint at UITableViewAlertForLayoutOutsideViewHierarchy to catch this in the debugger and see what caused this to occur, so you can avoid this action altogether if possible, or defer it until the table view has been added to a window. Table view: <UITableView: 0x7faed202de00; frame = (0 64; 320 504); clipsToBounds = YES; autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600002d1f7b0>; layer = <CALayer: 0x600002305a80>; contentOffset: {0, 0}; contentSize: {320, 4400}; adjustedContentInset: {0, 0, 0, 0}; dataSource: <Example.TableViewReloadVC: 0x7faed05080f0>>
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            }
        }
    }
    
    // ******************************* MARK: - Actions
    
    // ******************************* MARK: - Notifications
}

// ******************************* MARK: - InstantiatableFromStoryboard

extension TableViewReloadVC: InstantiatableFromStoryboard {}

// ******************************* MARK: - UITableViewDelegate, UITableViewDataSource

extension TableViewReloadVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
