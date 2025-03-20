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
    
    // for ShowSuggestedUsers
    var showSuggestedUsers: ShowSuggestedUsersModel?
    var onnShowSuggestionUsersLoaded: ((Bool) -> Void)?
    
    // for follow user
    var showFollowUser: FollowUserModel?
    var onShowFollowUserLoaded: ((Bool) -> Void)?
    
    // for following user
    var showFollowingUser: ShowFollowingModel?
    var onShowFollowingUserLoaded: ((Bool) -> Void)?
    
    // for show followers user
    var showFollowerUser: ShowFollowersModel?
    var onShowFollowersUserLoaded: ((Bool) -> Void)?
    
    
    

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
    
    
    func fetchProfileUserDetails(completion: @escaping (ShowUserDetailModel?) -> Void) {
           ApiManager.shared.apiRequest(endpoint: .showUserDetail) { (result: Result<ShowUserDetailModel, Error>) in
               switch result {
               case .success(let showUserDetails):
                   print("showUserDetails", showUserDetails)
                   
                   if showUserDetails.code == 202 {
                       Utility.shared.showToast(message: "Access Restricted")
                       completion(nil)  // Return nil if access is restricted
                       return
                   }
                   
                   self.showUserDetail = showUserDetails
                   completion(showUserDetails)  // Now returns data
                   
               case .failure(let error):
                   print("Fetch User Details Error: \(error.localizedDescription)")
                   completion(nil)  // Return nil in case of failure
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
    
    
    func showSuggestionUsers(parameters: [String: Any]){
        ApiManager.shared.apiRequest(endpoint: .showSuggestedUsers,parameters: parameters){(result: Result<ShowSuggestedUsersModel, Error>) in
            switch result {
            case.success(let showSuggestedUsers):
                print("Show Suggestions User:", showSuggestedUsers)
                if showSuggestedUsers.code == 202 {
                    Utility.shared.showToast(message: "Access Restricted")
                    return
                }
                self.showSuggestedUsers = showSuggestedUsers
                self.onnShowSuggestionUsersLoaded?(true)
            case.failure(let error):
                print("Show Suggestion Error: \(error.localizedDescription)")
                self.onnShowSuggestionUsersLoaded?(false)
            }
            
        }
        
    }
    

    
    func followUser(parameters: [String: Any]) {
        ApiManager.shared.apiRequest(endpoint: .followUser, parameters: parameters) { (result: Result<Int, Error>) in // Changed `FollowUserModel` to `Int`
            switch result {
            case .success(let statusCode):
                print("Follow API Response Code: \(statusCode)")
                
                if statusCode == 202 {
                    Utility.shared.showToast(message: "Access Restricted")
                    return
                }
                
                self.onShowFollowUserLoaded?(true)
                
            case .failure(let error):
                print("❌ Follow request failed: \(error.localizedDescription)")
                self.onShowFollowUserLoaded?(false)
            }
        }
    }
    
    
    
    
    func showFollowingUser(parameters: [String: Any]) {
        print("🔍 API Request Parameters: \(parameters)")

        ApiManager.shared.apiRequest(endpoint: .showFollowing, parameters: parameters) { (result: Result<ShowFollowingModel, Error>) in
            switch result {
            case .success(let showFollowingUser):
                print("✅ API Success - Show Suggestions User:", showFollowingUser)

                // Debugging: Checking the status code
                print("🔍 Response Code:", showFollowingUser.code)
                
                if showFollowingUser.code == 200 {
                    print("✅ Data Found: \(String(describing: showFollowingUser.msg))")
                    self.showFollowingUser = showFollowingUser
                    self.onShowFollowingUserLoaded?(true)
                    
                } else {
                    print("⚠️ No Data Available - Message:", showFollowingUser.message ?? "Unknown error")
                    if let message = showFollowingUser.message {
                        Utility.shared.showToast(message: message)
                    }
                    self.onShowFollowingUserLoaded?(true) // Ensure UI updates even if empty
                }
                
            case .failure(let error):
                print("❌ API Error: \(error.localizedDescription)")
                self.onShowFollowingUserLoaded?(false)
            }
        }
    }
    
    
    
    func showFollowersUser(parameters: [String: Any]) {
        print("🔍 API Request Parameters: \(parameters)")

        ApiManager.shared.apiRequest(endpoint: .showFollowers, parameters: parameters) { (result: Result<ShowFollowersModel, Error>) in
            switch result {
            case .success(let showFollowerUser):
                print("✅ API Success - Show Suggestions User:", showFollowerUser)

                // Debugging: Checking the status code
                print("🔍 Response Code:", showFollowerUser.code)
                
                if showFollowerUser.code == 200 {
                    print("✅ Data Found: \(String(describing: showFollowerUser.msg))")
                    self.showFollowerUser = showFollowerUser
                    self.onShowFollowersUserLoaded?(true)
                    
                } else {
                    print("⚠️ No Data Available - Message:", showFollowerUser.message ?? "Unknown error")
                    if let message = showFollowerUser.message {
                        Utility.shared.showToast(message: message)
                    }
                    self.onShowFollowersUserLoaded?(true) // Ensure UI updates even if empty
                }
                
            case .failure(let error):
                print("❌ API Error: \(error.localizedDescription)")
                self.onShowFollowersUserLoaded?(false)
            }
        }
    }



}
