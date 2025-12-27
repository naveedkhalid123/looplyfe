//
//  APIManager.swift
//
//
//  Created by Wasiq Tayyab on 08/02/2025.
//

import Alamofire
import Foundation

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://newapps.qboxus.com/tictic/api/"
    
    enum Endpoint: String {
        case showUserDetail
        case registerUser
        case checkUsername
        case checkEmail
        case showAllNotifications
        case showVideosAgainstUserID
        case showUserLikedVideos
        case showProfileVisitors
        case purchaseCoin
        case search
        case showDiscoverySections
        
        var path: String {
            return rawValue
        }
    }
    
    private func defaultHeaders() -> HTTPHeaders {
        print("UserDefaultsManager.shared.authToken",UserDefaultsManager.shared.authToken)
        return [
            "Content-Type": "application/json",
            "Api-Key": "156c4675-9608-4591-b2ec-427503464aac",
            "Auth-Token" : UserDefaultsManager.shared.authToken
        ]
    }
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Session(configuration: configuration)
    }()
    
    private func apiRequest<T: Codable>(endpoint: Endpoint,method: HTTPMethod = .post,parameters: Parameters? = nil,headers: [String: String]? = nil,completion: @escaping (Result<T, Error>) -> Void) {
        let url = baseURL + endpoint.path
        
        // Merge headers
        var allHeaders = defaultHeaders().dictionary
        if let customHeaders = headers {
            allHeaders.merge(customHeaders) { current, _ in current }
        }
        
        // Log request details
        print("Request URL: \(url)")
        print("Request Parameters: \(parameters)")
        
        session.request(url,method: method,parameters: parameters,encoding: JSONEncoding.default,headers: HTTPHeaders(allHeaders))
        .validate()
        .responseDecodable(of: T.self) { response in
            
            
            if let data = response.data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response:\n\(jsonString)")
                }
            }
            
            switch response.result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                print("Request Failed with Error: \(error.localizedDescription)")
                
                if let data = response.data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON Response:\n\(jsonString)")
                    }
                    do {
                        let decoder = JSONDecoder()
                        _ = try decoder.decode(T.self, from: data) // Test decoding
                    } catch let decodingError as DecodingError {
                        print("Decoding Error: \(decodingError.localizedDescription)")
                        
                        // Detailed error breakdown
                        switch decodingError {
                        case .typeMismatch(let type, let context):
                            print("Type Mismatch Error: Expected type \(type). \(context.debugDescription). CodingPath: \(context.codingPath)")
                        case .valueNotFound(let type, let context):
                            print("Value Not Found Error: Missing value for type \(type). \(context.debugDescription). CodingPath: \(context.codingPath)")
                        case .keyNotFound(let key, let context):
                            print("Key Not Found Error: Missing key '\(key.stringValue)'. \(context.debugDescription). CodingPath: \(context.codingPath)")
                        case .dataCorrupted(let context):
                            print("Data Corrupted Error: \(context.debugDescription). CodingPath: \(context.codingPath)")
                        @unknown default:
                            print("Unknown Decoding Error: \(decodingError)")
                        }
                    } catch {
                        print("Unexpected Decoding Error: \(error.localizedDescription)")
                    }
                } else {
                    print("Response Data is empty; unable to decode.")
                }
                completion(.failure(error))
            }
        }
    }
    
    private func apiRequestWithoutT(endpoint: Endpoint, method: HTTPMethod = .post, parameters: Parameters? = nil, headers: [String: String]? = nil, completion: @escaping (Result<Int, Error>) -> Void) {
        let url = baseURL + endpoint.path
        var allHeaders = defaultHeaders().dictionary
        
        if let customHeaders = headers {
            allHeaders.merge(customHeaders)
            { current, _ in current } }
        
        print("Request URL: \(url)")
        print("parameters: \(parameters)")
        
        session.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders(allHeaders)).response { response in
            
            if let responseData = response.data, let jsonString = String(data: responseData, encoding: .utf8) {
                print("Response Data: \(jsonString)")
            } else {
                print("Response Data: Unable to decode as UTF-8 string")
            }
            
            if let statusCode = response.response?.statusCode {
                switch statusCode {
                case 200, 201:
                    if let responseData = response.data {
                        do {
                            if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any], let code = jsonResponse["code"] as? Int {
                                if code == 201 {
                                    let msg = jsonResponse["msg"] as? String ?? "Unknown error message"
                                    let error = NSError(domain: "", code: 201, userInfo: [NSLocalizedDescriptionKey: msg])
                                    completion(.failure(error))
                                } else {
                                    completion(.success(statusCode))
                                }
                            } else {
                                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing 'code' field or invalid JSON response"])
                                completion(.failure(error))
                            }
                        } catch {
                            print("Error parsing response data: \(error)")
                            completion(.failure(error))
                        }
                    }
                default:
                    let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Unexpected status code: \(statusCode)"])
                    completion(.failure(error))
                }
            } else if let error = response.error {
                completion(.failure(error))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])
                completion(.failure(error))
            }
        }
    }
    
    
    func showUserDetailWithT( method: HTTPMethod = .post, completion: @escaping (Result<ShowUserDetailModel, Error>) -> Void){
        apiRequest(endpoint: .showUserDetail, method: method, completion: completion)
    }
    
    func showUserDetail( method: HTTPMethod = .post, completion: @escaping (Result<Int, Error>) -> Void){
        apiRequestWithoutT(endpoint: .showUserDetail, method: method, completion: completion)
    }
    
    func registerUser(parameters: Parameters, completion: @escaping (Result<Int, Error>) -> Void) {
        apiRequestWithoutT(endpoint: .registerUser, method: .post, parameters: parameters, completion: completion)
    }
    
    func checkUsername(parameters: Parameters, completion: @escaping (Result<Int, Error>) -> Void) {
        apiRequestWithoutT(endpoint: .checkUsername, method: .post, parameters: parameters, completion: completion)
    }
    
    func checkEmail(parameters: Parameters, completion: @escaping (Result<Int, Error>) -> Void){
        apiRequestWithoutT(endpoint: .checkEmail,method: .post, parameters: parameters, completion: completion)
    }
    
    func showAllNotifications(parameters: Parameters, completion: @escaping (Result<ShowAllNotificationsModel, Error>) -> Void) {
        apiRequest(endpoint: .showAllNotifications, method: .post, parameters: parameters, completion: completion)
    }
    
    func showVideosAgainstUserID( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<ShowVideosModel, Error>) -> Void){
        apiRequest(endpoint: .showVideosAgainstUserID, method: method, parameters: parameters, completion: completion)
    }
    
    func showUserLikedVideos( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<ShowUserLikedVideosModel, Error>) -> Void){
        apiRequest(endpoint: .showUserLikedVideos, method: method, parameters: parameters, completion: completion)
    }
    
    func showProfileVisitors( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<ShowUserLikedVideosModel, Error>) -> Void){
        apiRequest(endpoint: .showProfileVisitors, method: method, parameters: parameters, completion: completion)
    }

    func purchaseCoin( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<PurchaseCoinModel, Error>) -> Void){
        apiRequest(endpoint: .purchaseCoin, method: method, parameters: parameters, completion: completion)
    }
    
    func search( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<SearchUserModel, Error>) -> Void){
        apiRequest(endpoint: .search, method: method, parameters: parameters, completion: completion)
    }
   
    func searchSound( parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<SearchSoundModel, Error>) -> Void){
        apiRequest(endpoint: .search, method: method, parameters: parameters, completion: completion)
    }
    
    func searchHashtags(parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<SearchHastagsModel, Error>) -> Void){
        apiRequest(endpoint: .search, method: method, parameters: parameters, completion: completion)
    }
   
    func searchVideos(parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<SearchVideosModel, Error>) -> Void){
        apiRequest(endpoint: .search, method: method, parameters: parameters, completion: completion)
    }
    
    func discoverSections(parameters: Parameters,method: HTTPMethod = .post, completion: @escaping (Result<DiscoverySectionsModel, Error>) -> Void){
        apiRequest(endpoint: .showDiscoverySections, method: method, parameters: parameters, completion: completion)
    }


}
