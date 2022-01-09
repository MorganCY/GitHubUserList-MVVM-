//
//  UserRequest.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2022/1/9.
//

import Foundation

protocol Request {

    var endPoint: String { get }
}

enum UserRequest: Request {

    case userList

    case detailedUser(username: String)

    var endPoint: String {

        switch self {

        case .userList:
            return "/users?page=0&page_size=20"

        case .detailedUser(let username):
            return "/users/\(username)"
        }
    }
}
