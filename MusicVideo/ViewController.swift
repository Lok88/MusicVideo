//
//  ViewController.swift
//  MusicVideo
//
//  Created by Admin on 11/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    
    func didLoadData(result: String) {
        
        let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
            // no action required after pressing OK
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

