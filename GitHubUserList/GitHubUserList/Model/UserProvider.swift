//
//  UserProvider.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

final class UserProvider {

    static let shared = UserProvider()

    private init() {}

    typealias completionHandler = (Result<[User], Error>) -> Void

    func getUserList(completion: @escaping completionHandler) {
        guard let url = URL(string: "https://api.github.com/users?page=1&per_page=10") else { return }

        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let userListData = try decoder.decode([User].self, from: data)
                completion(.success(userListData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

