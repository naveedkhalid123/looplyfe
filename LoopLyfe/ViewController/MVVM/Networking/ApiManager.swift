//
//  ApiManager.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Alamofire
import Foundation

class ApiManager {
    // Store the class value inside the shared variable
    static let shared = ApiManager()
  
    // Store the url link inside the baseURL variable
    private let baseURL = "https://newapps.qboxus.com/tictic/api/"
  
    private var defaultHeaders: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            
            // Store API Key here
            "Api-Key": "156c4675-9608-4591-b2ec-427503464aac",
            
            // Use user default in API Manager for retriving the value
            "Auth-Token": "c8MfeuhwUsPK48Oa4AhvYm49Dyv2"
        ]
    }

    enum Endpoint: String {
        // Store API endpoint
        case showUserDetail
        // Store API endpoint
        case registerUser

        func url(baseURL: String) -> String {
            return baseURL + rawValue
        }
    }
  
    // make the fetch function , which will fetch the api request
    func fetchData<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        parameters: [String: Any]? = nil,
        method: HTTPMethod = .post,
        additionalHeaders: HTTPHeaders? = nil,
        completion: @escaping (Swift.Result<T, Error>) -> Void
    ) {
        let url = endpoint.url(baseURL: baseURL)
        let headers = additionalHeaders ?? defaultHeaders
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        
        print("🌍 Requesting: \(url)")
        print("🔄 Method: \(method)")
        print("📦 Parameters: \(parameters ?? [:])")
        print("📌 Headers: \(headers)")
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let decodedData = try decoder.decode(T.self, from: data)
                        print("✅ Successfully Decoded:", decodedData)
                        completion(.success(decodedData))
                    } catch let decodingError as DecodingError {
                        let handledError = self.handleDecodingError(decodingError)
                        print("❌ Decoding Failed: \(handledError.localizedDescription)")
                        completion(.failure(handledError))
                    } catch {
                        print("❌ Unknown Decoding Error: \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    print("❌ Request Failed: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }

    /// Handles decoding errors and provides detailed error messages.
    func handleDecodingError(_ error: DecodingError) -> NSError {
        switch error {
        case .valueNotFound(let type, let context):
            print("❌ Value Not Found: Expected \(type), but got null at \(context.codingPath).")
            return NSError(domain: "DecodingError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing expected data at \(context.codingPath)"])

        case .typeMismatch(let type, let context):
            print("❌ Type Mismatch: Expected \(type), but got a different type at \(context.codingPath).")
            return NSError(domain: "DecodingError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid data type at \(context.codingPath)"])

        case .keyNotFound(let key, let context):
            print("❌ Key Not Found: Missing key '\(key.stringValue)' at \(context.codingPath).")
            return NSError(domain: "DecodingError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Missing key '\(key.stringValue)' in response"])

        case .dataCorrupted(let context):
            print("❌ Data Corrupted: \(context.debugDescription)")
            return NSError(domain: "DecodingError", code: 4, userInfo: [NSLocalizedDescriptionKey: "Corrupted data received"])

        @unknown default:
            return NSError(domain: "DecodingError", code: 5, userInfo: [NSLocalizedDescriptionKey: "Unknown decoding error"])
        }
    }



}
