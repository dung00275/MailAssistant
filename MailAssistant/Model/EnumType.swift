//
//  EnumType.swift
//  MailAssistant
//
//  Created by Dung Vu on 7/1/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation

// MARK: - Mail Type
public enum UserMailType {
    case Google(account: String, token: String)
    case Yahoo(account: String, token: String, uri: String)
    case Live(account: String, token: String, uri: String)
    case Imap(account: String, password: String, host: String)
    case Exchange(email: String, password: String, host: String?, account: String?)
    
    var serviceName: String {
        switch self {
        case .Google:
            return "google"
        case .Yahoo:
            return "yahoo"
        case .Live:
            return "live"
        case .Imap:
            return "imap"
        case .Exchange:
            return "exchange"
        }
    }
}
