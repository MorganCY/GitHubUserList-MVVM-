//
//  UserProvider.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

typealias completionHandler<T> = (Result<T, Error>) -> Void

final class UserProvider {

    static let shared = UserProvider()

    var requestSince = 0

    var perRequestNumber = 20

    private init() {}

    func fetchUserInfo(
        endPoint: UserRequest,
        completion: @escaping completionHandler<Any>
    ) {

        guard let url = URL(string: "https://api.github.com\(endPoint.endPoint)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()

                switch endPoint {
                case .userList:
                    let userListData = try decoder.decode([User].self, from: data)
                    self?.requestSince += self?.perRequestNumber ?? 0
                    completion(.success(userListData))

                case .detailedUser(_):
                    let userDetail = try decoder.decode(User.self, from: data)
                    completion(.success(userDetail))
                }
            } catch {
                completion(.failure(error))
            }

        }.resume()
    }
}


