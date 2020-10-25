//
//  TopicCell.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit

class TopicCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var entryDate: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var commetns: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func show(data: ChildData) {
        if let imageUrl = data.thumbnail {
            imageCell.loadThumbnail(urlSting: imageUrl)
        }
        title.text = data.title
        
        author.text = data.author
       
        entryDate.text = String().timeAgoWillDisplay(data.created)

        commetns.text = "Comments: \(data.num_comments?.roundedWithAbbreviations ?? "0")"
    }
    
}
