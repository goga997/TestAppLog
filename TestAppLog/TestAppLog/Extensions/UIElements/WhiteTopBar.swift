//
//  WhiteTopBar.swift
//  TestAppLog
//
//  Created by Grigore on 02.08.2023.
//

import UIKit

class WhiteTopBar: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.image = UIImage(named: "whiteTop")
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
