//
//  TopicCell.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var imageCell: LoadingImageView!
    
    @IBOutlet weak var imageCellHeight: NSLayoutConstraint!
    
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
            if MethodHelp.verifyUrl(urlString: imageUrl) {
                imageCell.loadImage(from: imageUrl)
                imageCellHeight.constant = 210
            }else {
                imageCell.image = UIImage()
                imageCellHeight.constant = 20
            }
            
        }
        
        
        title.text = data.title
        
        author.text = data.author
        
        entryDate.text = String().timeAgoWillDisplay(data.created)
        
        commetns.text = "Comments: \(data.num_comments?.roundedWithAbbreviations ?? "0")"
    }
}

