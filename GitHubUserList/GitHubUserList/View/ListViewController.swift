//
//  ListViewController.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    let tableView = UITableView()

    let viewModel = ListViewModel()

    override func viewDidLoad() {
        setupTableView()

        self.viewModel.fetchUserList()

        viewModel.userViewModels.bind { [weak self] users in
            self?.viewModel.onRefresh()
        }
        
        viewModel.refreshView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        self.viewModel.userViewModels.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath)

        guard let userCell = cell as? ListTableViewCell else {
            return cell
        }
        let cellViewModel = self.viewModel.userViewModels.value[indexPath.row]
        userCell.layoutCell(viewModel: cellViewModel)

        return userCell
    }
}

extension ListViewController {

    func setupTableView() {
        tableView.dataSource = self
        view.stickSubView(tableView)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
}
