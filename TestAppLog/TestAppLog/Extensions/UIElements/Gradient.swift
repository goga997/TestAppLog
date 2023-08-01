//
//  Gradient.swift
//  TestAppLog
//
//  Created by Grigore on 31.07.2023.
//

import UIKit

class Gradient {
   static func createLinearGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds // Set the size of the gradient layer to fill the entire screen
        
        // Define the colors and their corresponding locations for the gradient
        let colors = [
            UIColor(hex: 0x1698FF).cgColor,
            UIColor(hex: 0x554CE8).cgColor,
            UIColor(hex: 0x4F50E9).cgColor,
            UIColor(hex: 0x0069C2).cgColor
        ]
        let locations: [NSNumber] = [
            -0.0106, // corresponding to #1698FF at 0% of the gradient
             0.8683,  // corresponding to #554CE8 at 86.83% of the gradient
             0.9096,  // corresponding to #4F50E9 at 90.96% of the gradient
             1.0210   // corresponding to #0069C2 at 102.1% of the gradient
        ]
        
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        
        // Set the start and end points of the gradient to create a linear direction
        gradientLayer.startPoint = CGPoint(x: 1, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        
        return gradientLayer
    }
}

// Helper extension to create UIColor from hex values
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}
