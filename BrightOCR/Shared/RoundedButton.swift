//
//  RoundedButton.swift
//  BrightOCR
//
//  Created by Kamajabu on 19/10/2020.
//

import UIKit

final class RoundedButton: UIButton {
    
    private lazy var shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
        shapeLayer.fillColor = customBackgroundColor.cgColor
        
        shapeLayer.strokeColor = borderColor.cgColor
        shapeLayer.borderWidth = 2
        
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowPath = shapeLayer.path
        shapeLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowRadius = 2
        
        return shapeLayer
    }()
    
    private let borderColor = UIColor.adaptedColor(light: UIColor.prussianBlue, dark: .white)
    private let customBackgroundColor = UIColor.adaptedColor(light: UIColor.redSalsa, dark: .darkSkyBlue)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if layer.sublayers?.contains(shapeLayer) == false {
            layer.insertSublayer(shapeLayer, at: 0)
        }
    }
    
    func updateColors() {
        shapeLayer.fillColor = customBackgroundColor.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
    }
    
}
