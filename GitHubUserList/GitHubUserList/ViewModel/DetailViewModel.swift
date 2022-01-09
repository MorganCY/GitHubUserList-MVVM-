//
//  DetailViewModel.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2022/1/9.
//

import Foundation

class DetailViewModel {

    var refreshView: (() -> Void)?

    let avatarImageUrl = Box("")
    let login = Box("")
    let bio = Box("")
    let siteAdmin = Box(false)
    let company = Box("")
    let email = Box("")
    let hireable = Box(false)

    func fetchUserDetail(username: String) {
        UserProvider.shared.fetchUserInfo(endPoint: .detailedUser(username: username)) { result in
            switch result {
            case .success(let userDetail):
                DispatchQueue.main.async {
                    self.setUserDetail(userDetail as! User)
                    self.refreshView?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func setUserDetail(_ userDetail: User) {
        avatarImageUrl.value = userDetail.avatarUrl
        login.value = userDetail.login
        siteAdmin.value = userDetail.siteAdmin
        company.value = userDetail.company ?? "Not provided"
        email.value = userDetail.email ?? "Not provided"
        hireable.value = userDetail.hireable ?? false
        bio.value = userDetail.bio ?? "Not provided"
    }
}
