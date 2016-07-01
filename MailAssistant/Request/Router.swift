//
//  Router.swift
//  MailAssistant
//
//  Created by Dung Vu on 7/1/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation

// MARK: - Router for Request
public enum Router {
    case Discovery(fileEml: String)
    
    var urlRequest: URLRequest? {
        
        // Prepare For Request
        var params: [String: AnyObject] = ["api_key": ApiKeyEasilydo.kKeyClient,
                                           "timestamp": String(Int(Date().timeIntervalSince1970))]
        
        var urlComponents = URLComponents(string: APIBaseURL)
        
        switch self {
        case .Discovery(let fileEml):
            urlComponents?.path = APIPath.discovery
            params["email"] = fileEml
            params = Parameter.makeParameters(fromParams: params,
                                              path: APIPath.discovery,
                                              method: .POST)
            
            guard let url = urlComponents?.url else {
                return nil
            }
            
            return EncodingParameterRequest.makeRequest(params, url: url, method: APIMethod.POST)
        }
    }
}
