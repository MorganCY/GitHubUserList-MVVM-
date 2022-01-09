//
//  DetailViewController.swift
//  GitHubUserListTest
//
//  Created by Zheng-Yuan Yu on 2022/1/2.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    let viewModel = DetailViewModel()
    let tableView = UITableView()
    var username: String

    // MARK: - Initializers
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchUserDetail(username: username)
        viewModel.refreshView = { [weak self] in
            self?.tableView.reloadData()
        }
        setupTableView()
        view.backgroundColor = .white
    }

    // MARK: - Functions
    func setupTableView() {
        view.addSubview(tableView)
        view.stickSubView(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerHeaderWithNib(identifier: DetailTableViewHeader.identifier, bundle: nil)
        tableView.registerCellWithNib(identifier: DetailTableViewCell.identifier, bundle: nil)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath)

        guard let detailCell = cell as? DetailTableViewCell else {
            return cell
        }
        detailCell.layoutCell(viewModel: viewModel, row: indexPath.row)
        return detailCell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeader.identifier)

        guard let detailHeader = header as? DetailTableViewHeader else {
            return header
        }
        detailHeader.layoutHeader(viewModel: viewModel)
        return detailHeader
    }
}
