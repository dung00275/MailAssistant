//
//  ViewController.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import UIKit
import CommonCrypto

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let locale = Locale.current().localeIdentifier
//        
//        let _ = RequestManager.sharedInstance.request(router: .AddUser(nameUser: "test", locale: locale)) { (result, response) in
//            let json = result.json
//            let error = result.error
//            
//            print(json, error?.localizedDescription)
//            
//        }
        
        
        let _ = RequestManager.sharedInstance.request(router: .GetEmailConnections(nameUser: "test")) { (result, response) in
            let json = result.json
            let error = result.error
            
            print(json, error?.localizedDescription)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

