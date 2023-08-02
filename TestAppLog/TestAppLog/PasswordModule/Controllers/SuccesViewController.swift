//
//  SuccesViewController.swift
//  TestAppLog
//
//  Created by Grigore on 02.08.2023.
//

import UIKit

class SuccesViewController: UIViewController {
    
    private let gradientLayer = Gradient.createLinearGradient()
    
    private let titleText = UILabel(text: "Congrats you succesfully set your pin!",
                                    font: .montserratBold24())
    private let descriptionText = UILabel(text: "Your password is",
                                          font: .montserratBold24())
    
    private lazy var mainScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to main Screen", for: .normal)
        button.layer.cornerRadius = 30
        button.titleLabel?.font = .montserratRegular20()
        button.titleLabel?.textColor = #colorLiteral(red: 0.0862745098, green: 0.5960784314, blue: 1, alpha: 1)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(mainScreenButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - VIEW LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showPassword()
        setUpView()
        setConstraints()
    }
    
    //MARK: - SetUpView
    private func setUpView() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(mainScreenButton)
    }
    
    @objc private func mainScreenButtonTapped() {
        DataBase.shared.deleteValueFromUserDefaults(forKey: "password")
        print(DataBase.shared.getData()) //verification
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    private func showPassword() {
        descriptionText.text = "Your password is\n\(DataBase.shared.getData())"
    }
}

//MARK: - CONSTRAINTS
extension SuccesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            mainScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainScreenButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8205),
            mainScreenButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15384),
        ])
    }
}
