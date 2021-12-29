//
//  Kingfisher.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {

    func loadImage(_ urlString: String, placeHolder: UIImage? = nil) {

        let url = URL(string: urlString)

        self.kf.indicatorType = .activity

        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
