//
//  ConfirmPasswordViewController.swift
//  TestAppLog
//
//  Created by Grigore on 01.08.2023.
//

import UIKit

class ConfirmPasswordViewController: UIViewController {
    
    public var digitsFromSetController = ""
    private var digitsFromConfirmController = ""
    private let gradientLayer = Gradient.createLinearGradient()
    var textFields: [WhiteTextField] = []
    
    private lazy var whiteTopBar = WhiteTopBar(frame: .zero)
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleText = UILabel(text: "Confirm password",
                                    font: .montserratBold26())
    private let descriptionText = UILabel(text: "Confirm your account password",
                                          font: .montserratRegular14())
    
    private lazy var confirmButton = PasswordButton(text: "Confirm")
    
    //MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstraints()
        setupTextFields()
        offKeyboard()
    }
    
    //MARK: - SetUpView
    private func setUpView() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(whiteTopBar)
        view.addSubview(backButton)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        view.addSubview(confirmButton)
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
    private func concatenateDigitsFromConfirmTextFields() {
        digitsFromConfirmController = ""
            for textField in textFields {
                if let text = textField.text, let digit = text.first, digit.isNumber {
                    digitsFromConfirmController.append(digit)
                }
            }
        }
    
    @objc private func confirmButtonTapped() {
        concatenateDigitsFromConfirmTextFields()
        let succesVC = SuccesViewController()
        if digitsFromSetController == digitsFromConfirmController {
            DataBase.shared.addData(data: digitsFromConfirmController)
            succesVC.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.6
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            present(succesVC, animated: false, completion: nil)
        } else {
            presentSimpleAlert(title: "Unsucces", message: "Please complete all the fields and make sure they match the password")
            textFields.forEach({$0.deleteValueFromTextField()})
        }
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
extension ConfirmPasswordViewController: UITextFieldDelegate {
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
extension ConfirmPasswordViewController {
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
            titleText.heightAnchor.constraint(equalToConstant: 27),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            descriptionText.heightAnchor.constraint(equalToConstant: 15),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25641),
            confirmButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.11538),
            
        ])
    }
}

