//
//  SpecificButton.swift
//  BestMovie
//
//  Created by Khemissi Houssem Eddin on 06/01/2019.
//  Copyright © 2019 Nizar Elhraiech. All rights reserved.
//

import UIKit


@IBDesignable
class SpecificButton: UIButton {
    
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
