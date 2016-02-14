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
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
        musicImage.image = UIImage(named: "cat")
        
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
