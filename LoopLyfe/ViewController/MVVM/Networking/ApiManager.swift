//
//  ApiManager.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 11/03/2025.
//

import Foundation
import Alamofire

class ApiManager {
  
  static let shared = ApiManager()
  
  private let baseURL = "https://newapps.qboxus.com/tictic/api/"
  
    private var defaultHeaders: HTTPHeaders {
        return [
            "Content-Type": "application/json",
            "Api-Key": "156c4675-9608-4591-b2ec-427503464aac",
            
            // Use user default in API Manager for retriving the value
            "Auth-Token": UserDefaults.standard.string(forKey: "AuthToken") ?? ""
        ]
    }

  
  enum Endpoint: String {
    case showUserDetail = "showUserDetail"

    func url(baseURL: String) -> String {
      return baseURL + self.rawValue
    }
  }
  
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
      
      print("URL:", url)
      print("Parameters:", parameters ?? [:])
      print("Headers:", headers)
      
      AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
          .validate()
          .responseDecodable(of: T.self) { response in
              print("Response:", response)
              switch response.result {
              case .success(let data):
                  completion(.success(data))
              case .failure(let error):
                  completion(.failure(error))
              }
          }
  }
}

