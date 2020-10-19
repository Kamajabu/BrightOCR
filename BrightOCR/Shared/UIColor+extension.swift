//
//  UIColor+extension.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

extension UIColor {
    
    class var prussianBlue: UIColor {
        UIColor(red: 23/255, green: 42/255, blue: 58/255, alpha: 1.0)
    }
    
    class var darkSkyBlue: UIColor {
        UIColor(red: 116/255, green: 179/255, blue: 206/255, alpha: 1.0)
    }
    
    class var redSalsa: UIColor {
        UIColor(red: 240/255, green: 58/255, blue: 71/255, alpha: 1.0)
    }
    
    class var barBackground: UIColor {
        adaptedColor(light: darkSkyBlue, dark: prussianBlue)
    }
    
    class func adaptedColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13, *) else {
            return light
        }
        
        return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
            return UITraitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }
}
