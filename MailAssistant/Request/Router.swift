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
    case AddUser(nameUser: String, locale: String)
    
    case GetEmailConnections(nameUser: String)
    case AddEmailConnection(nameUser: String, mail: UserMailType)
    
    case GetListSifts(nameUser: String)
    
    var urlRequest: URLRequest? {
        
        // Prepare For Request
        var params: [String: AnyObject] = ["api_key": ApiKeyEasilydo.kKeyClient,
                                           "timestamp": Int(Date().timeIntervalSince1970)]
        
        var urlComponents = URLComponents(string: APIBaseURL)
        var method = APIMethod.POST
        switch self {
        case .Discovery(let fileEml):
            urlComponents?.path = APIPath.discovery
            params["email"] = fileEml
            
        case .AddUser(let nameUser ,let locale):
            urlComponents?.path = APIPath.addUser
            params["username"] = nameUser
            params["locale"] = locale
        
        case .GetEmailConnections(let nameUser):
            method = .GET
            let path = String(format: APIPath.emailConnections, nameUser)
            urlComponents?.path = path
            
        case .AddEmailConnection(let nameUser, let mail):
            let path = String(format: APIPath.emailConnections, nameUser)
            urlComponents?.path = path
            params["account_type"] = mail.serviceName
            
            // Tracking for each service
            switch mail {
            case .Google(let account, let token):
                params["account"] = account
                params["refresh_token"] = token
            case .Yahoo(let account, let token, let uri):
                params["account"] = account
                params["refresh_token"] = token
                params["redirect_uri"] = uri
            case .Live(let account, let token, let uri):
                params["account"] = account
                params["refresh_token"] = token
                params["redirect_uri"] = uri
            case .Imap(let account, let password,let host):
                params["account"] = account
                params["password"] = password
                params["host"] = host
            case .Exchange(let email, let password, let host, let account):
                params["email"] = email
                params["password"] = password
                params["host"] = host
                params["account"] = account
            }
            
        case .GetListSifts(let nameUser):
            method = .GET
            let path = String(format: APIPath.listSifts, nameUser)
            urlComponents?.path = path
        }
        
        guard let url = urlComponents?.url, path = urlComponents?.path else {
            return nil
        }
        
        params = Parameter.makeParameters(fromParams: params,
                                          path: path,
                                          method: method)
        
        return EncodingParameterRequest.makeRequest(params, url: url, method: method)
    }
}
