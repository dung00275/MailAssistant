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
        
        guard let pathEml = Bundle.main().urlForResource("example", withExtension: "eml")?.path else {
            return
        }
        do {
            let data = try String(contentsOfFile: pathEml).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let _ = RequestManager.sharedInstance.request(router: .Discovery(fileEml: data),
                                                  completion:
                { (data, response, error) in
                
                guard let data = data where error == nil else {
                    return
                }
                do{
                    let json =  try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let newError as NSError {
                    print(newError.localizedDescription)
                }
            })
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

