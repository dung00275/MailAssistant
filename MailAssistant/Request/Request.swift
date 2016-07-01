//
//  Request.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import Foundation


public class RequestManager: NSObject {
    
    public static let sharedInstance = RequestManager()
    
    private lazy var session: URLSession = {
        let queue = OperationQueue()
        queue.name = "RequestManager.Excuting.Request"
        queue.qualityOfService = .utility
        
        let newSession = URLSession(configuration: URLSessionConfiguration.default(),
                                    delegate: nil,
                                    delegateQueue: queue)
        
        return newSession
        
    }()
    
    override init() {
        super.init()
    }
    
    public func request(router: Router, completion: (Data?, URLResponse?, NSError?) -> ()) -> URLSessionDataTask? {
        guard let request = router.urlRequest else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnsupportedURL, userInfo: [NSLocalizedDescriptionKey : "URL request nil!!"])
            completion(nil, nil, error)
            return nil
        }
        
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()
        
        return dataTask
    }
    
    public func cancelAll() {
        session.invalidateAndCancel()
    }
    
    
}


