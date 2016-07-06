//
//  AppDelegate.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import UIKit
import GoogleSignIn
import GGLSignIn
import YahooLogin
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var session: YahooSession?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = Google.kClientId
        return true
    }

   
    func application(_ app: UIApplication, open url: URL, options: [String : AnyObject] = [:]) -> Bool {
        
        if url.absoluteString?.contains("com.googleusercontent.apps") ?? false {
            guard let sourceApplication = options[UIApplicationLaunchOptionsSourceApplicationKey] as? String else {
                return false
            }
            let annotation = options[UIApplicationOpenURLOptionsAnnotationKey]
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication: sourceApplication,
                                                     annotation: annotation)
        }
        
        
        return true
        
    }


}



