//
//  ApiManager.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//
import Alamofire
import Foundation

enum NetworkError: Error {
    case noInternet
    case timedOut
    case serverUnavailable
    case decodingFailed
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network settings."
        case .timedOut:
            return "The request timed out. Please try again later."
        case .serverUnavailable:
            return "The server is unavailable. Please try again later."
        case .decodingFailed:
            return "Failed to decode the server response."
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
}


class ApiManager {
    static let shared = ApiManager()
    
    private let baseURL = "https://newapps.qboxus.com/tictic/api/"
    
    private static func headers() -> HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Api-Key": "156c4675-9608-4591-b2ec-427503464aac",
            "Auth-Token": "tGy1hQKd1ESBxm56KJDfdQ8D3Js2"
        ]
    }
    
    enum Endpoint: String {
        case showUserDetail
        case registerUser
        case showSuggestedUsers
        case followUser
        case showFollowing
        case showFollowers
        case showVideosAgainstUserID
        case showUserLikedVideos
        case showUserRepostedVideos
        case showAllNotifications
        case search
        
        func url(baseURL: String) -> String {
            return baseURL + rawValue
        }
    }
    
    // MARK: - API Request with Decodable Response
    func apiRequest<T: Codable>(endpoint: Endpoint, method: HTTPMethod = .post, parameters: Parameters? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        let url = endpoint.url(baseURL: baseURL)
        print("url", url)
        print("parameters", parameters)
        
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default,headers: HTTPHeaders(ApiManager.headers().dictionary))
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let model):
                    
                    completion(.success(model))
                case .failure(let error):
            
                    // Attempt to decode the response and log decoding errors with more detail
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            _ = try decoder.decode(T.self, from: data)
                        } catch let decodingError as DecodingError {
                            switch decodingError {
                            case .typeMismatch(let type, let context):
                                print("Type Mismatch: Expected \(type), \(context.debugDescription)")
                                print("Coding Path: \(context.codingPath)")
                            case .valueNotFound(let type, let context):
                                print("Value Not Found: Expected \(type), \(context.debugDescription)")
                                print("Coding Path: \(context.codingPath)")
                            case .keyNotFound(let key, let context):
                                print("Key Not Found: \(key), \(context.debugDescription)")
                                print("Coding Path: \(context.codingPath)")
                            case .dataCorrupted(let context):
                                print("Data Corrupted: \(context.debugDescription)")
                                print("Coding Path: \(context.codingPath)")
                            @unknown default:
                                print("Unhandled Decoding Error: \(decodingError)")
                            }
                        } catch {
                            print("Other Error: \(error.localizedDescription)")
                        }
                    } else {
                        print("No data received in the response.")
                    }

                    // Handle the original error
                    if let afError = error.asAFError {
                        switch afError {
                        case .sessionTaskFailed(let urlError as URLError):
                            switch urlError.code {
                            case .notConnectedToInternet:
                                print("No internet connection.")
                                completion(.failure(NetworkError.noInternet))
                            case .timedOut:
                                print("Request timed out.")
                                completion(.failure(NetworkError.timedOut))
                            case .cannotFindHost, .cannotConnectToHost:
                                print("Cannot connect to server.")
                                completion(.failure(NetworkError.serverUnavailable))
                            default:
                                print("Network error: \(urlError.localizedDescription)")
                                completion(.failure(NetworkError.unknown))
                            }
                        default:
                            print("AFError: \(afError.localizedDescription)")
                            completion(.failure(NetworkError.unknown))
                        }
                    } else {
                        completion(.failure(error))
                    }

                    
                }
            }
    }
    
    func apiRequestWithoutT(endpoint: Endpoint, method: HTTPMethod = .post, parameters: Parameters? = nil, completion: @escaping (Result<Int, Error>) -> Void) {
        let url = endpoint.url(baseURL: baseURL)
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default,headers: HTTPHeaders(ApiManager.headers().dictionary))
            .response { response in
                if let statusCode = response.response?.statusCode {
                    switch statusCode {
                    case 200, 201:
                        completion(.success(statusCode))
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
}
