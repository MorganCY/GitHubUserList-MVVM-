//
//  User.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

struct User: Codable {

    var login: String
    var avatarUrl: String
    var siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case siteAdmin = "site_admin"
    }
}
