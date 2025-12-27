//
//  DiscoveryViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 23/12/2025.
//

import Foundation

protocol DiscoverSectionUpdater: AnyObject {
    func didUpdateDiscoverSection()
    func didFailDiscoverSection(error: Error)
}

final class DiscoveryViewModel {
    
    private var isLoading = false
    weak var discoverSectionDelegate : DiscoverSectionUpdater?
    var discoverySections: [DiscoveryMsg] = []
    private var apiManager = APIManager()
    
    func flagVariabe(apiCall: Bool){
        isLoading = apiCall
    }
    
    func getApiCall() -> Bool {
        return isLoading
    }
    
    func discoverSections(userID: Int, startingPoint: Int) {
        let params: [String: Any] = [
            "user_id": userID,
            "starting_point": startingPoint
        ]

        apiManager.discoverSections(parameters: params) { result in
            switch result {
            case .success(let response):
                if startingPoint == 0 {
                    self.discoverySections.removeAll()
                    self.discoverySections = response.msg ?? []
                } else {
                    self.discoverySections.append(contentsOf: response.msg ?? [])
                }
                
                self.discoverSectionDelegate?.didUpdateDiscoverSection()
            case .failure(let error):
                print("Error:", error.localizedDescription)
                self.discoverSectionDelegate?.didFailDiscoverSection(error: error)
            }
        }
    }

}
