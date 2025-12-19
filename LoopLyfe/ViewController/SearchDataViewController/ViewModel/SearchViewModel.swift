//
//  SearchViewModel.swift
//  LoopLyfe
//
//  Created by iMac on 11/12/2025.
//

import Foundation

protocol SearchUserUpdater: AnyObject {
    func didUpdateSearchUser()
    func didFailUpdateSearchUser(error: Error)
}

protocol SearchSoundUpdater: AnyObject {
    func didUpdateSound()
    func didFailUpdateSound(error: Error)
}

protocol SearchHashtagsUpdater: AnyObject {
    func didUpdateHashtags()
    func didFailHashtags(error: Error)
}

protocol SearchVideoUpdater: AnyObject {
    func didUpdateVideo()
    func didFailVideo(error: Error)
}

final class SearchViewModel {
    
    private var isLoading = false
    
    weak var searchDelegate : SearchUserUpdater?
    weak var soundDelegate : SearchSoundUpdater?
    weak var hashtagsDelegate : SearchHashtagsUpdater?
    weak var videosDelegate : SearchVideoUpdater?
    
    var searchUser : [SearchUserMsg] = []
    var searchSound : [SoundMsg] = []
    var searchHashtags : [HastagsMsg] = []
    var searchVideos : [SearchVideosMsg] = []
    
    private var apiManager = APIManager()
    
    func flagVariabe(apiCall: Bool){
        isLoading = apiCall
    }
    
    func getApiCall() -> Bool {
        return isLoading
    }
    
    // MARK: - Search User
    func searchUser(userId: String, type: String, keyword: String, stratingPoint: String){
        
        let params : [String: Any] = [
            "user_id": userId,
            "type": type,
            "keyword": keyword,
            "starting_point": stratingPoint
        ]
        
        apiManager.search(parameters: params) { result in
            switch result {
            case .success(let response):
                if stratingPoint == "0" {
                    self.searchUser.removeAll()
                    self.searchUser = response.msg ?? []
                }else {
                    self.searchUser.append(contentsOf: response.msg ?? [])
                }
                
                self.searchDelegate?.didUpdateSearchUser()
            case .failure(let error):
                self.searchDelegate?.didFailUpdateSearchUser(error: error)
            }
        }
    }
    
    // MARK: - Search Sound
    func searchSound (userId: String, type: String, keyword: String, stratingPoint: String){
        let params : [String: Any] = [
            "user_id": userId,
            "type": type,
            "keyword": keyword,
            "starting_point": stratingPoint
        ]
        
        apiManager.searchSound(parameters: params) { result in
            switch result {
            case .success(let response):
                if stratingPoint == "0" {
                    self.searchSound.removeAll()
                    self.searchSound = response.msg ?? []
                }else {
                    self.searchSound.append(contentsOf: response.msg ?? [])
                }
                
                self.soundDelegate?.didUpdateSound()
            case .failure(let error):
                self.soundDelegate?.didFailUpdateSound(error: error)
            }
        }
    }
    
    // MARK: - Search Hashtags
    func searchHashtags (userId: String, type: String, keyword: String, stratingPoint: String){
        let params : [String: Any] = [
            "user_id": userId,
            "type": type,
            "keyword": keyword,
            "starting_point": stratingPoint
        ]
        
        apiManager.searchHashtags(parameters: params) { result in
            switch result {
            case .success(let response):
                if stratingPoint == "0" {
                    self.searchHashtags.removeAll()
                    self.searchHashtags = response.msg ?? []
                }else {
                    self.searchHashtags.append(contentsOf: response.msg ?? [])
                }
                
                self.hashtagsDelegate?.didUpdateHashtags()
            case .failure(let error):
                self.hashtagsDelegate?.didFailHashtags(error: error)
            }
        }
    }
    
    // MARK: - Search Videos
    func searchVideos (userId: String, type: String, keyword: String, stratingPoint: String){
        let params : [String: Any] = [
            "user_id": userId,
            "type": type,
            "keyword": keyword,
            "starting_point": stratingPoint
        ]
        
        apiManager.searchVideos(parameters: params) { result in
            switch result {
            case .success(let response):
                if stratingPoint == "0" {
                    self.searchVideos.removeAll()
                    self.searchVideos = response.msg ?? []
                }else {
                    self.searchVideos.append(contentsOf: response.msg ?? [])
                }
                
                self.videosDelegate?.didUpdateVideo()
            case .failure(let error):
                 self.videosDelegate?.didFailVideo(error: error)
                print("error",error)
            }
        }
    }
}
