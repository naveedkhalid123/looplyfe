//
//  NotificationsViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 11/11/2025.
//

import Foundation

protocol NotificationsUpdater: AnyObject {
    func didUpdateNotifications(_ notifications: [ShowAllNotificationsMsg])
    func didFailToUpdateNotifications(error: Error)
}

final class NotificationsViewModel {
    weak var delegate: NotificationsUpdater?
    private let apiManager = APIManager()
    
    var notifications: [ShowAllNotificationsMsg] = []
    private var shouldSkipAPI = false
    
    func fetchNotifications(startPoint: Int) {
        guard !shouldSkipAPI else {
            print("API call skipped because previous response was 201")
            return
        }
        
        let params = ["starting_point": startPoint.toString()]
        
        apiManager.showAllNotifications(parameters: params) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.code == 201 {

                    self.shouldSkipAPI = true
                    print("API returned 201, future calls will be skipped")
                    return
                }
                
                if startPoint == 0 {
                    self.notifications = model.msg ?? []
                } else {
                    self.notifications.append(contentsOf: model.msg ?? [])
                }
                
                self.delegate?.didUpdateNotifications(self.notifications)
                
            case .failure(let error):
                self.delegate?.didFailToUpdateNotifications(error: error)
            }
        }
    }
}

extension Int {
    func toString() -> String {
        return String(self)
    }
    func toDouble() -> Double {
        return Double(self)
    }
}
 
extension Double {
    func toString() -> String {
        return String(self)
    }
    func toInt() -> Int? {
        return Int(self)
    }
}
 
 
extension String {
    func toInt() -> Int? {
        return Int(self)
    }
    
    func toDouble() -> Double? {
        return Double(self)
    }
}
