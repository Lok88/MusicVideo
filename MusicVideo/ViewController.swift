//
//  ViewController.swift
//  MusicVideo
//
//  Created by Admin on 11/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    
    func didLoadData(videos: [Videos]) {
        
        self.videos = videos
        
        for item in videos {
            print("name = \(item.vName)")
        }
        
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }

        
        /* let alert = UIAlertController(title: result, message: nil, preferredStyle: .Alert)
           let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
               // no action required after pressing OK
           }
           alert.addAction(okAction)
           self.presentViewController(alert, animated: true, completion: nil)
        */
        
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

