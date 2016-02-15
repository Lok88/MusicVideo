//
//  MusicVideoTableViewCell.swift
//  MusicVideo
//
//  Created by Admin on 14/2/2016.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video: Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    func updateCell() {
        
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        // musicImage.image = UIImage(named: "cat")
        
        if video!.vImageData != nil {
            print("Get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData!)
        } else {
            getVideoImage(video!, imageView: musicImage)
            print("Get images in background thread")
        }
    }
    
    
    func getVideoImage(video: Videos, imageView: UIImageView) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            var image: UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
