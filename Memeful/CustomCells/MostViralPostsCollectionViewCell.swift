//
//  MostViralPostsCollectionViewCell.swift
//  Memeful
//
//  Created by Koushik Dutta on 15/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit
import SDWebImage

class MostViralPostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var upPoints: UILabel!
    
    var postDetails : Datum?{
        didSet{
            if let postDetails = postDetails {
                self.title.text = postDetails.title
                self.upPoints.text = String(postDetails.ups ?? 0)
                if let image = postDetails.images?.first?.link{
                    if image.contains("gif") || image.contains("png") || image.contains("jpg") || image.contains("jpeg"){
                        self.imageView.sd_setImage(with: URL(string: image))
                        let height = (UIScreen.main.bounds.width/2 - 10) * CGFloat(postDetails.images?.first?.aspectRatio ?? 1)
                        imageHeightConstraint.constant = height
                    }else{
                        self.imageView.image = #imageLiteral(resourceName: "play_button_icon")
                        imageHeightConstraint.constant = 133
                    }
                }else{
                    self.imageView.image = #imageLiteral(resourceName: "play_button_icon")
                    imageHeightConstraint.constant = 133
                }
                //self.imageView.sd_setImage(with: postDetails.imageUrl)
            } 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageWidthConstraint.constant = UIScreen.main.bounds.width/2 - 10
    }
}
