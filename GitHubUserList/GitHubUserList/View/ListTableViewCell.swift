//
//  ListTableViewCell.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {

    let avatarImageView = UIImageView()
    let loginLabel = UILabel()
    let adminLabel = UILabel()
    var viewModel: UserViewModel?

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        avatarImageView.image = nil
    }

    private func setupViews() {

        let views = [avatarImageView, loginLabel, adminLabel]
        views.forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        loginLabel.numberOfLines = 0
        loginLabel.textColor = .black
        adminLabel.numberOfLines = 0
        adminLabel.textColor = .black
        adminLabel.textAlignment = .right

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),

            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            loginLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),

            adminLabel.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 16),
            adminLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            adminLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }

    func layoutCell(viewModel: UserViewModel) {

        self.viewModel = viewModel
        layoutCell()
    }

    private func layoutCell() {

        guard let viewModel = viewModel else { return }
        loginLabel.text = viewModel.login
        adminLabel.text = "Site Admin: \(viewModel.admin)"
        avatarImageView.loadImage(viewModel.avatarImageUrl, placeHolder: nil)
    }
}
