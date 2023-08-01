//
//  WhiteTextField.swift
//  TestAppLog
//
//  Created by Grigore on 01.08.2023.
//
import UIKit

class WhiteTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        font = .interRegular32()
        textAlignment = .center
        keyboardType = .numberPad
        translatesAutoresizingMaskIntoConstraints = false
    }
}


