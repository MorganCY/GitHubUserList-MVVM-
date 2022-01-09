//
//  DetailTableViewCell.swift
//  GitHubUserListTest
//
//  Created by Zheng-Yuan Yu on 2022/1/8.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {

    var viewModel: DetailViewModel?
    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func layoutCell(viewModel: DetailViewModel, row: Int) {
        self.viewModel = viewModel
        layoutCell(row: row)
    }

    private func layoutCell(row: Int) {
        guard let viewModel = viewModel else { return }
        switch row {
        case 0 :
            columnNameLabel.text = DetailColumn.bio.rawValue
            viewModel.bio.bind { [weak self] bio in
                self?.contentLabel.text = bio
            }
        case 1:
            columnNameLabel.text = DetailColumn.siteAdmin.rawValue
            viewModel.siteAdmin.bind { [weak self] isAdmin in
                self?.contentLabel.text = "\(isAdmin)"
            }
        case 2:
            columnNameLabel.text = DetailColumn.company.rawValue
            viewModel.company.bind { [weak self] company in
                self?.contentLabel.text = company
            }
        case 3:
            columnNameLabel.text = DetailColumn.email.rawValue
            viewModel.email.bind { [weak self] email in
                self?.contentLabel.text = email
            }
        case 4:
            columnNameLabel.text = DetailColumn.hireable.rawValue
            viewModel.email.bind { [weak self] hireable in
                self?.contentLabel.text = "\(hireable)"
            }
        default:
            break
        }
    }
}
