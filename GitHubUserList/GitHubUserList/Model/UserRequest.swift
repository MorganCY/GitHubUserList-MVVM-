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

    case userList(since: Int, perRequest: Int)

    case detailedUser(username: String)

    var endPoint: String {

        switch self {

        case .userList(let since, let perRequest):
            return "/users?since=\(since)&per_page=\(perRequest)"

        case .detailedUser(let username):
            return "/users/\(username)"
        }
    }
}
