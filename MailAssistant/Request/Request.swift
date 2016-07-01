//
//  Request.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation

// MARK: - Wrapper result
public struct Result{
    let json: [String: AnyObject]?
    let error: NSError?
}

// MARK: - RequestManager
public class RequestManager: NSObject {
    
    public static let sharedInstance = RequestManager()
    
    private lazy var session: URLSession = {
        
        let configuration = URLSessionConfiguration.default()
        configuration.timeoutIntervalForRequest = 30
        
        let queue = OperationQueue()
        queue.name = "RequestManager.Excuting.Request"
        queue.qualityOfService = .utility
        
        let newSession = URLSession(configuration: configuration,
                                    delegate: nil,
                                    delegateQueue: queue)
        
        return newSession
        
    }()
    
    override init() {
        super.init()
    }
    
    public func request(router: Router, completion: (Result, URLResponse?) -> ()) -> URLSessionDataTask? {
        guard let request = router.urlRequest else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: [NSLocalizedDescriptionKey : "URL request nil!!"])
            completion(Result(json: nil, error: error), nil)
            return nil
        }
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result(json: nil, error: error), response)
            }else {
                guard let data = data else {
                    let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotParseResponse, userInfo: [NSLocalizedDescriptionKey : "No Response!!"])
                    completion(Result(json: nil, error: error), nil)
                    return
                }
                
                completion(data.convertToJson(), response)
            }
            
            
        }
        dataTask.resume()
        
        return dataTask
    }
    
    public func cancelAll() {
        session.invalidateAndCancel()
    }
    
    
}


