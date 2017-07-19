//
//  FancyView.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 19/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() {
        //Always put the super in!
        super.awakeFromNib()
        
        //Shadow
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
}
