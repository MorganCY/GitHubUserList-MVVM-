//
//  MJRefresh.swift
//  GitHubUserListTest
//
//  Created by Zheng-Yuan Yu on 2022/1/8.
//

import Foundation
import UIKit
import MJRefresh

extension UITableView {

    func addRefreshFooter(refreshingBlock: @escaping () -> Void) {
        mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: refreshingBlock)
    }

    func endFooterRefreshing() {
        mj_footer?.endRefreshing()
    }

    func endWithNoMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }
}
