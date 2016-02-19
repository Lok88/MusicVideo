//
//  ViewController.swift
//  MusicVideo
//
//  Created by Admin on 11/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Videos]()
    var limit = 10

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChanged", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    
    func preferredFontChanged() {
        print("The preferred Font has changed")
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

        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
        title = ("The iTunes Top \(limit) Music Videos")
           
        
        
        
        tableView.reloadData()
        
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
        case NOACCESS:
            // view.backgroundColor = UIColor.redColor()
            // move back to Main Queue
            dispatch_async(dispatch_get_main_queue()) {
            
            let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action -> () in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
                action -> () in
                print("delete")
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
                print("Ok")
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            self.presentViewController(alert, animated: true, completion: nil)
            }

        default:
            // view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }

        }
    }
    
    
    @IBAction func refresh(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        runAPI()
    }
    
    
    
    func getAPICount() {
        if (NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil) {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDte = formatter.stringFromDate(NSDate())
        
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDte)")
    }
    
    func runAPI() {
        
        getAPICount()
        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        cell.video = videos[indexPath.row]

        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier
        {
            if let indexPath = tableView.indexPathForSelectedRow {
                let video = videos[indexPath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

