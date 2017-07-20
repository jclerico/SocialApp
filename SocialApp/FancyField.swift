//
//  FancyField.swift
//  SocialApp
//
//  Created by Jeremy Clerico on 19/07/2017.
//  Copyright © 2017 Jeremy Clerico. All rights reserved.
//

import UIKit

class FancyField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.2).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }
    
    //Changes Placeholder text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    //Changes actual text when entered by user
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
}
