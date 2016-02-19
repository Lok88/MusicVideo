//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Admin on 16/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicVideoDetailVC: UIViewController {
    
    var videos:Videos!
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        } else {
            videoImage.image = UIImage(named: "cat")
        }
        
    }
    
    
    @IBAction func socialMedia(sender: UIButton) {
        shareMedia()
    }
    
    
    func shareMedia() {
        let activity1 = "Have you had the opportunity to see this Music Video ?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think ?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step It Up !)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)

        
        // activityViewController.excludedActivityTypes = [UIActivityTypeMail, ]
        
        // activityViewController.excludedActivityTypes = [
        //    UIActivityTypePostToTwitter,
        //    UIActivityTypePostToFacebook,
        //    UIActivityTypePostToWeibo,
        //    UIActivityTypeMessage,
        //    UIActivityTypeMail,
        //    UIActivityTypePrint,
        //    UIActivityTypeCopyToPasteboard,
        //    UIActivityTypeAssignToContact,
        //    UIActivityTypeSaveToCameraRoll,
        //    UIActivityTypeAddToReadingList,
        //    UIActivityTypePostToFlickr,
        //    UIActivityTypePostToVimeo,
        //    UIActivityTypePostToTencentWeibo,
        // ]
        
       
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if activity == UIActivityTypeMail {
                print("eMail selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func playVideo(sender: UIButton) {
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
