//
//  ApiService.swift
//  ClosestVenues
//
//  Created by Amosiejko on 19/04/2022.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    func request<T:Decodable>(_ apiRequest: ApiRequest,
                   completion: @escaping (T) -> Void,
                   failure: @escaping (ApiError) -> Void) {
        
        let headers = [
          "Accept": "application/json",
          "Authorization": "fsq37FX2EBFd4sTR/wACVc1bTojEQirU72aDVvjvm9/L7H0="
        ]
        
        var urlString = ""
        if let parameters = apiRequest.parameters?.queryParams(), apiRequest.method == .get {
            var components = URLComponents()
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
            urlString = apiRequest.path.basePath + apiRequest.path.subPath + (components.url?.absoluteString ?? "")
        } else {
            urlString = apiRequest.path.basePath + apiRequest.path.subPath
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue.uppercased()
        request.allHTTPHeaderFields = headers
        
        if apiRequest.method == .post {
            if let parameters = apiRequest.parameters?.queryParams() {
                let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = httpBody
            }
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                    completion(response)
            } catch(let error) {
                print(error)
                failure(error as! ApiError)
                return
            }
        })
        dataTask.resume()
    }
}
