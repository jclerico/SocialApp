//
//  PostCell.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 22/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
