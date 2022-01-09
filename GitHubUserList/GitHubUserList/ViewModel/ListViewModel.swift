//
//  ListViewModel.swift
//  GitHubUserList
//
//  Created by Zheng-Yuan Yu on 2021/12/28.
//

import Foundation

class ListViewModel {

    let userViewModels = Box([UserViewModel]())

    var refreshView: (()->())?
    
    func fetchUserList() {

        UserProvider.shared.fetchUserInfo(endPoint: .userList) { [weak self] result in
            switch result {
            case .success(let userList):
                self?.setUserList(userList as! [User])
            case .failure(let error):
                print("fetch user list failure: \(error)")
            }
        }
    }

    func onRefresh() {
        self.refreshView?()
    }

    func convertUsersToViewModels(from users: [User]) -> [UserViewModel] {
        var viewModels = [UserViewModel]()
        for user in users {
            let viewModel = UserViewModel(user)
            viewModels.append(viewModel)
        }
        return viewModels
    }

    func setUserList(_ userList: [User]) {
        userViewModels.value = convertUsersToViewModels(from: userList)
    }
}
