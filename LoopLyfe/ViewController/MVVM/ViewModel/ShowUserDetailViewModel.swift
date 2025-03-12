//
//  ShowUserDetailViewModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Foundation

class ShowUserDetailViewModel {
    // Give here model name
    var showUserDetail: ShowUserDetailModel?
    var onShowUserDetailsLoaded: ((Bool,Int) -> Void)?
    var showRegisterUser: RegisterUserModel?
    var onRegisterUserLoaded: ((Bool) -> Void)?
    
    func fetchUserDetails() {
        // send request to alamofire to fetch data and return the result
        ApiManager.shared.fetchData(endpoint: .showUserDetail, responseType: ShowUserDetailModel.self) { result in
            switch result {
            case .success(let showUserDetails):
                // assign the result to showUserDetails
                self.showUserDetail = showUserDetails
                self.onShowUserDetailsLoaded?(true,self.showUserDetail?.code ?? 0)
            case .failure(let error):
                print(error)
                self.onShowUserDetailsLoaded?(false,404)
            }
        }
    }
    
    func registerUser(parameters: [String : Any]) {
        // send request to alamofire to fetch data and return the result
        ApiManager.shared.fetchData(endpoint: .registerUser, responseType: RegisterUserModel.self,parameters:parameters) { result in
            switch result {
            case .success(let showRegisterUser):
                print("showRegisterUser",showRegisterUser)
                // assign the result to showRegisterUser
                self.showRegisterUser = showRegisterUser
                // call the closure
                self.onRegisterUserLoaded?(true)
            case .failure(let error):
                print(error)
                self.onRegisterUserLoaded?(false)
            }
        }
    }
}
