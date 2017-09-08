//
//  UITableViewController.swift
//  SelfTaping
//
//  Created by Evgeny Yagrushkin on 2017-09-08.
//  Copyright © 2017 Casting Workbook Services Inc. All rights reserved.
//

extension UITableViewController{
    
    func sizeHeaderToFit() {
        
        let headerView = tableView.tableHeaderView!
        let oldHeight = headerView.frame.size.height
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        if oldHeight == headerView.frame.size.height {
            return
        }
        tableView.tableHeaderView = headerView
    }
    
}
