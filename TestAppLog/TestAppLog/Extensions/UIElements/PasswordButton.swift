//
//  PasswordButton.swift
//  TestAppLog
//
//  Created by Grigore on 01.08.2023.
//

import UIKit

class PasswordButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(type: .system)
        self.setTitle(text, for: .normal)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.4705882353, blue: 0.9764705882, alpha: 1)
        titleLabel?.font = .montserratRegular18()
        tintColor = .white
        layer.cornerRadius = 24
        translatesAutoresizingMaskIntoConstraints = false
    }
}
