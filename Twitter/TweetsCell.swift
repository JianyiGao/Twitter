//
//  TweetsCell.swift
//  Twitter
//
//  Created by Jianyi Gao 高健一 on 2/25/17.
//  Copyright © 2017 Jianyi Gao. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    var tweet: Tweet!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame
            .width
        tweetLabel.text = tweet?.text
        print("*******")
        print(tweet.text!)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
