//
//  ConfigApi.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation

let APIBaseURL = "https://api.easilydo.com"

// MARK: - Key Using In App
struct ApiKeyEasilydo {
    static let kKeyClient = "039a08f212f03bdbeff959bcedaa87ef"
    static let kKeySecret = "a7a0c929426469ea9cc5ccb47d8dfac11370b8bb"
    static let kKeyPublic = "9edcab0443cc50824a234c660690eb"
}

struct Google {
    static let kClientId = "122106404544-scs58on68s24fv89rlautnt9v0t670ev.apps.googleusercontent.com"
}

struct Yahoo {
    static let kClientId = "dj0yJmk9VFJrQXdHd2VqNjA1JmQ9WVdrOVlWSkJlbUZRTlRJbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD03MQ--"
    static let kSerectId = "b8a84c1847f88a3577caf57f3d1112e1d0c23edf"
}

// MARK: - Method
public enum APIMethod: String {
    case POST = "POST"
    case GET = "GET"
    case UNKNOWN = ""
}

// MARK: - API path
public struct APIPath {
    // Eml file
    static let discovery                = "/v1/discovery"
    
    // User
    static let deleteUser               = "/v1/users/%@"
    static let addUser                  = "/v1/users"
    
    // Email connection
    static let emailConnections         = "/v1/users/%@/email_connections"
    static let deleteEmailConnection    = "/v1/users/%@/email_connections/%@"
    
    // Sifts
    static let listSifts                = "/v1/users/%@/sifts"
    static let getSifts                 = "/v1/users/%@/sifts/%@"
    
    //Connect Tokens
    static let postConnectToken         = "/v1/connect_token"
    
    //Connect Emails
    static let getConnectEmail          = "/v1/connect_email"
    
    //Feedbacks
    static let postFeedback             = "/v1/feedback"
    
}







