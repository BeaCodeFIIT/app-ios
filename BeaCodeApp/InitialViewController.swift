//
//  ViewController.swift
//  BeaCodeApp
//
//  Created by Peter Augustín on 3.10.16.
//  Copyright © 2016 Peter Augustín. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let testURL = "https://api.spotify.com/v1/search?q=Drake&type=album"
        NetworkServiceManager.sharedInstance.request(url: testURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
