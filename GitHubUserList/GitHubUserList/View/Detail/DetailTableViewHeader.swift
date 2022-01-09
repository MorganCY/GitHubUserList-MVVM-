//
//  DetailTableViewHeader.swift
//  GitHubUserListTest
//
//  Created by Zheng-Yuan Yu on 2022/1/8.
//

import Foundation
import UIKit

class DetailTableViewHeader: UITableViewHeaderFooterView {

    var viewModel: DetailViewModel?
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }

    func layoutHeader(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        layoutHeader()
    }

    private func layoutHeader() {
        guard let viewModel = viewModel else { return }
        viewModel.avatarImageUrl.bind { [weak self] imageUrl in
            self?.avatarImageView.loadImage(imageUrl, placeHolder: nil)
        }
        viewModel.login.bind { [weak self] login in
            self?.loginLabel.text = login
        }
    }
}
