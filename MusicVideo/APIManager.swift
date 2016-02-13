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
        let task = session.dataTaskWithURL(url) {(data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        task.resume()
    }
}