//
//  RoundButton.swift
//  RNDM
//
//  Created by Ścibor Budkowski on 09/09/2020.
//  Copyright © 2020 Ścibor Budkowski. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
