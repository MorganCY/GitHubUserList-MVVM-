//
//  UserViewModel.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

class UserViewModel {

    var user: User

    init(_ user: User) {
        self.user = user
    }

    var avatarImageUrl: String {
        get {
            return user.avatarUrl
        }
    }

    var login: String {
        get {
            return user.login
        }
    }

    var admin: Bool {
        get {
            return user.siteAdmin
        }
    }
}
