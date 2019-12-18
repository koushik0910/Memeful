//
//  PostImageTableViewCell.swift
//  Memeful
//
//  Created by Koushik Dutta on 16/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
import SDWebImage

class PostImageTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    var postDetails : Datum?{
         didSet{
             if let postDetails = postDetails {
                self.title.text = postDetails.title
                if let image = postDetails.images?.first?.link{
                    if image.contains("gif") || image.contains("png") || image.contains("jpg") || image.contains("jpeg"){
                        self.postImageView.sd_setImage(with: URL(string: image))
                    }else{
                        self.postImageView.image = #imageLiteral(resourceName: "play_button_icon")
                    }
                }else{
                    self.postImageView.image = #imageLiteral(resourceName: "play_button_icon")
                }
                //self.postImageView.sd_setImage(with: postDetails.imageUrl)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
