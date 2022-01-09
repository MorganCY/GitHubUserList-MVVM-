//
//  ListViewModel.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

class ListViewModel {

    let userViewModels = Box([UserViewModel]())

    // Refresh targeting view
    var refreshView: (() -> Void)?
    var endFooterRefreshing: (() -> Void)?
    var endWithNoMoreData: (() -> Void)?

    func fetchUserList() {
        UserProvider.shared.fetchUserInfo(
            endPoint: .userList(
            since: UserProvider.shared.requestSince,
            perRequest: UserProvider.shared.perRequestNumber)
        ) { [weak self] result in
            switch result {
            case .success(let userList):
                self?.setUserList(userList as! [User])
                self?.endFooterRefreshing?()
            case .failure(let error):
                print(error)
            }
        }
    }

    // Refresh the user list data on targeting view
    func onRefresh() {
        self.refreshView?()
    }

    func setUserList(_ userList: [User]) {
        userViewModels.value += convertUsersToViewModels(from: userList)
    }

    func convertUsersToViewModels(from users: [User]) -> [UserViewModel] {
        var viewModels = [UserViewModel]()
        for user in users {
            let viewModel = UserViewModel(user)
            viewModels.append(viewModel)
        }
        return viewModels
    }
}
