//
//  APIManager.swift
//  MusicVideo
//
//  Created by Admin on 11/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString: String, completion: (result: String) -> Void) {
    
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                }
            } else {
                // print(data)
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String: AnyObject] {
                           print(json)
                           let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(result: "Error in NSJSONSerialization")
                    }
                    
                }
            }
        }
        task.resume()
    }
}