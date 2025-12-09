//
//  ProfileViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 24/11/2025.
//

import Foundation

protocol ShowUserDetailsUpdater : AnyObject {
    func didUpdateUserProfile(_ userProfile: ShowUserDetailMsg)
    func didFailUpdateUserProfile(error: Error)
}

protocol ShowUserVideosUpdater : AnyObject {
    func didUpdateUserVideo(_ userVideo: VideoMsg)
    func didFailUpdateUserVideo(error: Error)
}

protocol ShowLikeVideosUpdater : AnyObject {
    func didUpdateUserLikeVideo(likeVideo: [Private])
    func didFailUserLikeVideo(error: Error)
}

final class ProfileViewModel {
    weak var delegate: ShowUserDetailsUpdater?
    weak var videoDelegate: ShowUserVideosUpdater?
    weak var likeVideosDelegate: ShowLikeVideosUpdater?
    
    private let apiManager = APIManager()
    
    func fetchUserDetails(){
        
        apiManager.showUserDetailWithT { result in
            switch result {
            case .success(let userDetail):
                print("User detail:", userDetail)
                if let detail = userDetail.msg {
                    self.delegate?.didUpdateUserProfile(detail)
                }
            case .failure(let error):
                print("Error:", error.localizedDescription)
                self.delegate?.didFailUpdateUserProfile(error: error)
            }
        }
    }
    
    func showVideosAgainstUserID(userID: Int, startingPoint: Int) {
        
        let params: [String: Any] = [
            "user_id": userID,
            "starting_point": startingPoint
        ]
        
        apiManager.showVideosAgainstUserID(parameters: params) { result in
            switch result {
            case .success(let userVideo):
                print("Video:", userVideo)
                
                if let video = userVideo.msg {
                    self.videoDelegate?.didUpdateUserVideo(video)
                }
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
                self.videoDelegate?.didFailUpdateUserVideo(error: error)
            }
        }
    }
    
    func showUserLikeVideos(userID: Int, startingPoint: Int) {
        
        let params: [String: Any] = [
            "user_id": userID,
            "starting_point" : startingPoint
        ]
        
        apiManager.showUserLikedVideos(parameters: params) { result in
            switch result {
            case .success(let likeVideo):
                print("LikeVideos:", likeVideo)
                
                if let video = likeVideo.msg {
                    self.likeVideosDelegate?.didUpdateUserLikeVideo(likeVideo: video)
                }
                
            case .failure(let error):
                print("Error:", error.localizedDescription)
                self.likeVideosDelegate?.didFailUserLikeVideo(error: error)
            }
        }
        
    }

}
