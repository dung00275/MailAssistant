//
//  YahooService.swift
//  MailAssistant
//
//  Created by Dung Vu on 7/5/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation
import YahooLogin

protocol YahooServiceDelegate: class {
    func willYahooLogin()
    func didLoginYahooSuccessful(result: YOSResponseData?)
    func didLoginYahooFail(error: NSError?)
    func didLoginYahooCancel()
}

class YahooService: NSObject {
    static let sharedInstance = YahooService()
    
    private lazy var session: YahooSession! = {
        return  YahooSession(consumerKey: Yahoo.kClientId,
                             andConsumerSecret: Yahoo.kSerectId,
                             andApplicationId: "Email Parse",
                             andCallbackUrl: "https://api.easilydo.com",
                             andDelegate: self)
    }()
    
    private var isExcuting: Bool = false
    
    
    weak var delegate: YahooServiceDelegate?
    
    func alreadyLogin() -> Bool {
        return session.resumeSession()
    }
    
    func signIn() {
        if !isExcuting {
            isExcuting = true
            self.delegate?.willYahooLogin()
            if alreadyLogin() {
                sendUserProfileRequest()
            }else {
                session.sendUserToAuthorization()
            }
        }
        
    }
    
    func token() -> YOSAccessToken? {
        return self.session.accessToken
    }
    
    private func sendUserProfileRequest() {
        // Initialize profile request
        isExcuting = true
        let userRequest = YOSUserRequest(session: session)
        userRequest?.fetchProfile(withDelegate: self)
    }
    
}

// MARK: - Session delegate
extension YahooService: YahooSessionDelegate {
    func didReceiveAuthorization() {
        var isReadyLogin: Bool = false
        DispatchQueue(label: "Sync.AccessToken").sync(execute: { () -> () in
            isReadyLogin = alreadyLogin()
            if isReadyLogin {
                sendUserProfileRequest()
            }else {
                isExcuting = false
                let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: [NSLocalizedDescriptionKey: "Not have access token!!!"])
                self.delegate?.didLoginYahooFail(error: error)
            }
            
        })
        
        
        
//        if alreadyLogin() {
//            DispatchQueue(label: "Sync.AccessToken").sync(execute: { () -> () in
//                sendUserProfileRequest()
//            })
//            return
//        }
        
        
    }
    func didFailAuthoriaztion(_ error: NSError!) {
        isExcuting = false
        self.delegate?.didLoginYahooFail(error: error)
    }
    
    func didCancelLogin() {
        isExcuting = false
        self.delegate?.didLoginYahooCancel()
    }
}

// MARK: - Request Delegate
extension YahooService: YOSRequestDelegate {
    func connectionWasCancelled() {
        isExcuting = false
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: [NSLocalizedDescriptionKey : "Cancelled request"])
        self.delegate?.didLoginYahooFail(error: error)
    }
    
    func requestDidFailWithError(_ error: YOSResponseData!) {
        print("Error!!!")
        isExcuting = false
        self.delegate?.didLoginYahooFail(error: error.error)
    }
    
    func requestDidFinishLoading(_ result: YOSResponseData!) {
        
        self.delegate?.didLoginYahooSuccessful(result: result)
        isExcuting = false
        print("finish!!!")
    }
}
