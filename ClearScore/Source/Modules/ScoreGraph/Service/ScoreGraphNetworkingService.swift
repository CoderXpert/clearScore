//
//  ScoreGraphNetworkingService.swift
//  ClearScore
//
//  Created by luca silvestro on 04/03/18.
//  Copyright © 2018 Clear Score. All rights reserved.
//

import Foundation
import ObjectMapper

class ScoreGraPhNetworkingService: ScoreGraPhNetworkingServiceInterface {
    
    private let defaultSession = URLSession(configuration: .default)
    private let url = URL(string: ScoreGraPhNetworkingService.Constants.scoreURL)!
    private var dataTask: URLSessionDataTask?
    private var networkError: NetworkingError?
    
    /// Attempts to fetch credit score infos and executes the the completion closure
    ///
    /// - Parameter completion: Closure to execute after the request
    func fetchCreditScoreInfo(completion: @escaping NetworkingCompletion) {
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            
            defer { self.dataTask = nil }
            
            if let error = error {
                self.networkError = .failed(message: error.localizedDescription)
                DispatchQueue.main.async {
                    completion(self.networkError, nil)
                }
                return
            }
            
            if let creditReportInfo = self.parse(data: data, response: response) {
                
                DispatchQueue.main.async {
                    completion(self.networkError, creditReportInfo)
                }
                
            } else {
                
                self.networkError = NetworkingError.failed(message: "There was an error! The request was not succesfull")
                DispatchQueue.main.async {
                    completion(self.networkError, nil)
                }
            }
            
        }
        
        dataTask?.resume()
    }
    
    
    /// Parses the result we get back from the server into its own model
    ///
    /// - Parameters:
    ///   - data: data object returned by the dataTask
    ///   - response: response object returned by the dataTask
    /// - Returns: CreditReportInfo? model
    private func parse(data: Data?, response: URLResponse?) -> CreditReportInfo? {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
                return nil
            }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return Mapper<CreditReportInfo>().map(JSONObject: json)
    }
}

// MARK: - Constants
extension ScoreGraPhNetworkingService {
    struct Constants {
        static let scoreURL = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
    }
}
