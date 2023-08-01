//
//  SetPasswordViewController.swift
//  TestAppLog
//
//  Created by Grigore on 01.08.2023.
//

import UIKit

class SetPasswordViewController: UIViewController {
    
    private let gradientLayer = Gradient.createLinearGradient()
    var textFields: [WhiteTextField] = []
    
    private lazy var whiteTopBar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "whiteTop")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleText = UILabel(text: "Secure your account",
                                    font: .montserratBold26())
    private let descriptionText = UILabel(text: "Secure your account by setting password",
                                          font: .montserratRegular14())
    
    private lazy var setButton = PasswordButton(text: "Set")
    
    //MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        setupTextFields()
        offKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //width - 390; height - 844; iPhone 14
        gradientLayer.frame = view.bounds //for screen rotation
    }
    
    //MARK: - SetUpView
    private func setUpView() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(whiteTopBar)
        view.addSubview(backButton)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        
        setButton.addTarget(self, action: #selector(setButtonTapped), for: .touchUpInside)
        view.addSubview(setButton)
    }
    
    private func setupTextFields() {
        var previousTextField: WhiteTextField?
        
        for index in 0..<5 {
            let whiteTextField = WhiteTextField()
            whiteTextField.delegate = self
            
            textFields.append(whiteTextField)
            view.addSubview(whiteTextField)
            
            NSLayoutConstraint.activate([
                whiteTextField.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1435),
                whiteTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1435),
            ])
            
            // Align the first text field to the leading edge
            if index == 0 {
                whiteTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            } else {
                // Position the subsequent text fields next to the previous one with a horizontal spacing
                whiteTextField.leadingAnchor.constraint(equalTo: previousTextField!.trailingAnchor, constant: 15).isActive = true
            }
            
            // Position all text fields at the same top anchor
            whiteTextField.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 50).isActive = true
            
            // Save the current text field as the previousTextField for the next iteration
            previousTextField = whiteTextField
        }
    }
    
    //Collecting digits function
    private func concatenateDigitsFromTextFields() -> String {
        var digits = ""
            for textField in textFields {
                if let text = textField.text, let digit = text.first, digit.isNumber {
                    digits.append(digit)
                }
            }
            return digits
        }
    
    @objc private func setButtonTapped() {
        let confirmPasswordVC = ConfirmPasswordViewController()
        confirmPasswordVC.digitsFromSetController = concatenateDigitsFromTextFields()
        confirmPasswordVC.modalPresentationStyle = .fullScreen
        
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(confirmPasswordVC, animated: false, completion: nil)
    }
    
    //MARK: - KEYBOARD
    private func offKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - BackButton
    @objc private func backButtonTapped() {
        let transition = CATransition()
        transition.duration = 1.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SetPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let whiteTextField = textField as? WhiteTextField, let character = string.first, character.isNumber {
            textField.text = character.description
            moveToNextTextField(from: whiteTextField)
            return false
        }
        return true
    }
    
    private func moveToNextTextField(from textField: WhiteTextField) {
        guard let currentIndex = textFields.firstIndex(of: textField) else {
            textField.resignFirstResponder()
            return
        }
        let nextIndex = currentIndex + 1
        if nextIndex < textFields.count {
            textFields[nextIndex].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}

//MARK: - CONSTRAINTS
extension SetPasswordViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            whiteTopBar.topAnchor.constraint(equalTo: view.topAnchor),
            whiteTopBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteTopBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteTopBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 17),
            
            titleText.topAnchor.constraint(equalTo: whiteTopBar.bottomAnchor, constant: -30),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleText.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            descriptionText.heightAnchor.constraint(equalToConstant: 35),
            
            setButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            setButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            setButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25641),
            setButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11538),
            
        ])
    }
}

