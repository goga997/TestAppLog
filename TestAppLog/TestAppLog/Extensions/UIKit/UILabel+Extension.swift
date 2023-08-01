//
//  UILabel+Extension.swift
//  TestAppLog
//
//  Created by Grigore on 31.07.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String = "", font: UIFont?) {
        self.init()
        self.text = text
        self.textColor = .white
        self.font = font
        self.textAlignment = .center
        self.numberOfLines = 2
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
