//
//  ViewController.swift
//  MailAssistant
//
//  Created by Dung Vu on 6/30/16.
//  Copyright © 2016 Zinio Pro. All rights reserved.
//

import UIKit
import CommonCrypto
import GoogleSignIn
import YahooLogin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let locale = Locale.current().localeIdentifier
        
//        let _ = RequestManager.sharedInstance.request(router: .AddUser(nameUser: "test", locale: locale)) { (result, response) in
//            let json = result.json
//            let error = result.error
//            
//            print(json, error?.localizedDescription)
//
//        }
        
        
//        let _ = RequestManager.sharedInstance.request(router: .GetEmailConnections(nameUser: "test")) { (result, response) in
//            let json = result.json
//            let error = result.error
//            
//            print(json, error?.localizedDescription)
//            
//        }
        
//        let _ = RequestManager.sharedInstance.request(router: .GetListSifts(nameUser: "test")) { (result, response) in
//            let json = result.json
//            let error = result.error
//            
//            print(json, error?.localizedDescription)
//            
//        }
        let time = DispatchTime.now()
        DispatchQueue.main.after(when: time) { [weak self] in
            self?.signInYahoo()
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showAlert(title: String? ,message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(OKAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Yahoo
extension ViewController: YahooServiceDelegate {
    
    func signInYahoo() {
        YahooService.sharedInstance.delegate = self
        YahooService.sharedInstance.signIn()
        
    }
    
    func willYahooLogin() {
        
    }
    
    func didLoginYahooSuccessful(result: YOSResponseData?){
        print(result?.responseJSONDict)
        
        let token: YOSAccessToken? = YahooService.sharedInstance.token()
        print(token?.tokenAsDictionary())
    }
    func didLoginYahooFail(error: NSError?){
        showAlert(title: "", message: error?.localizedDescription)
    }
    
    func didLoginYahooCancel() {
        print("Cancel login");
    }
}


// MARK: - Google
extension ViewController {
    func signInGoogle() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain() {
            GIDSignIn.sharedInstance().signInSilently()
        }else {
            GIDSignIn.sharedInstance().signIn()
        }

    }
    
    func addUserGoogle (email: String, token: String){
        
        let _ = RequestManager.sharedInstance.request(router: Router.AddEmailConnection(nameUser: "test", mail: .Google(account: email, token: token))) { (result, response) in
            let json = result.json
            let error = result.error
            
            print(json, error?.localizedDescription)

        }
    }
}

// Got result
extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: NSError!) {
        if error == nil && user != nil {
            print(user.profile.givenName)
            print("token : \(user.authentication.accessToken)")
            
            // try add service
            addUserGoogle(email: user.profile.email, token: user.authentication.accessToken)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: NSError!) {
        if error == nil && user != nil {
            print(user)
        }
    }
}

// Show sign In
extension ViewController: GIDSignInUIDelegate{
    func sign(inWillDispatch signIn: GIDSignIn!, error: NSError!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

