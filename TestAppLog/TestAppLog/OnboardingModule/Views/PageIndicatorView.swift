//
//  FirstIndicatorView.swift
//  TestAppLog
//
//  Created by Grigore on 31.07.2023.
//

import UIKit

class PageIndicatorView: UIView {
    
    public let firstIndicator: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.2
        view.layer.cornerRadius = 5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let secondIndicator: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.2
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let thirdIndicator: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.2
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var firstIndicatorView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpView() {
        firstIndicatorView = UIStackView(arrangedSubviews: [firstIndicator,
                                                            secondIndicator,
                                                            thirdIndicator],
                                         axis: .horizontal,
                                         spacing: 9)
        self.addSubview(firstIndicatorView)
    }
    
    public func animationFirst() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1) {
                self.firstIndicator.alpha = 1
                self.firstIndicator.isHidden = false
                self.firstIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
                self.secondIndicator.widthAnchor.constraint(equalToConstant: 17).isActive = true
                self.thirdIndicator.widthAnchor.constraint(equalToConstant: 17).isActive = true

            }
        }
    }
    
    private func setConstraits() {
        NSLayoutConstraint.activate([
            
//            firstIndicator.widthAnchor.constraint(equalToConstant: 17),
//            secondIndicator.widthAnchor.constraint(equalToConstant: 17),
//            thirdIndicator.widthAnchor.constraint(equalToConstant: 17),

            firstIndicatorView.topAnchor.constraint(equalTo: self.topAnchor),
            firstIndicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstIndicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            firstIndicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
