//
//  ShowUserDetailViewModel.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Foundation

class ShowUserDetailViewModel {
    var showUserDetail: ShowUserDetailModel?
    var onShowUserDetailsLoaded: ((Bool, Int) -> Void)?
    var showRegisterUser: RegisterUserModel?
    var onRegisterUserLoaded: ((Bool) -> Void)?

    func fetchUserDetails() {
        ApiManager.shared.apiRequest(endpoint: .showUserDetail) { (result: Result<ShowUserDetailModel, Error>) in
            switch result {
            case .success(let showUserDetails):
                print("showUserDetails",showUserDetails)
                if showUserDetails.code == 202 {
                    Utility.shared.showToast(message: "Access Restricted")
                    return
                }
                self.showUserDetail = showUserDetails
                self.onShowUserDetailsLoaded?(true, showUserDetails.code)
            case .failure(let error):
                print("Fetch User Details Error: \(error.localizedDescription)")
                self.onShowUserDetailsLoaded?(false, 404)
            }
        }
    }
    
    func registerUser(parameters: [String: Any]) {
        ApiManager.shared.apiRequest(endpoint: .registerUser,parameters: parameters) { (result: Result<RegisterUserModel, Error>) in
            switch result {
            case .success(let showRegisterUser):
                print("Registered User:", showRegisterUser)
                if showRegisterUser.code == 202 {
                    Utility.shared.showToast(message: "Access Restricted")
                    return
                }
                self.showRegisterUser = showRegisterUser
                self.onRegisterUserLoaded?(true)
            case .failure(let error):
                print("Register User Error: \(error.localizedDescription)")
                self.onRegisterUserLoaded?(false)
            }
        }
    }
}
