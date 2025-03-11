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
    
    var onShowUserDetailsLoaded: ((Bool) -> Void)?
    
    func fetchUserDetails() {
        //send request to alamofire to fetch data and return the result
        ApiManager.shared.fetchData(endpoint: .showUserDetail, responseType: ShowUserDetailModel.self) { result in
            switch result {
            case .success(let showUserDetails):
                //assign the result to showFilms
                self.showUserDetail = showUserDetails
              //  print(self.showUserDetail)
                //call the closure
                self.onShowUserDetailsLoaded?(true)
            case .failure(let error):
                print(error)
                self.onShowUserDetailsLoaded?(false)
            }
        }
    }
}
