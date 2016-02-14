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

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
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
    
  
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS: view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI: view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN: view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachability with Cellular"
        default: return
        }
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

