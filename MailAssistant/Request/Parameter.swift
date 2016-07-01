//
//  Parameter.swift
//  MailAssistant
//
//  Created by Dung Vu on 7/1/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation


// MARK: - Make parameter
public struct Parameter {
    
    static func makeParameters (fromParams params: [String: AnyObject],
                                path: String,
                                method: APIMethod) -> [String: AnyObject]
    {
        var params = params
        let keys = params.keys.sorted(isOrderedBefore: {return $0 < $1})
        // Make Signature
        var baseString = method.rawValue.uppercased() + "&" + path
        
        for key in keys {
            baseString += "&" + key + "=" + "\(params[key]!)"
        }
        
        let signature: String = baseString.hmac(.SHA1, key: ApiKeyEasilydo.kKeySecret)
        params["signature"] = signature
        
        return params
    }
}
