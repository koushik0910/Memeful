//
//  BestCommentsTableViewCell.swift
//  Memeful
//
//  Created by Koushik Dutta on 16/12/19.
//  Copyright © 2019 Koushik Dutta. All rights reserved.
//

import UIKit

class BestCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var authorName: UILabel!
    var commentDetails : CommentDetails?{
         didSet{
             if let commentDetails = commentDetails {
                self.authorName.text = commentDetails.author
                self.comment.text = commentDetails.comment
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
