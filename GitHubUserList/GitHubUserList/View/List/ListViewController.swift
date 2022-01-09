//
//  ListViewController.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    // MARK: - Properties
    let tableView = UITableView()
    let viewModel = ListViewModel()

    // MARK: Lifecycle
    override func viewDidLoad() {
        setupVC()
        setupTableView()
        addTableViewFooterLoader()
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

    // MARK: - Functions
    func addTableViewFooterLoader() {
        tableView.addRefreshFooter { [weak self] in
            self?.viewModel.fetchUserList()
        }

        viewModel.endFooterRefreshing = { [weak self] in
            self?.tableView.endFooterRefreshing()
        }

        viewModel.endWithNoMoreData = { [weak self] in
            self?.tableView.endWithNoMoreData()
        }
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellViewModel = viewModel.userViewModels.value[indexPath.row]
        let userDetailVC = DetailViewController(username: cellViewModel.login)
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

// MARK: - Setup UI
extension ListViewController {

    func setupVC() {
        view.backgroundColor = .white
        title = "GitHub User List"
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.stickSubView(tableView)
        tableView.registerCellWithNib(identifier: ListTableViewCell.identifier, bundle: nil)
    }
}
