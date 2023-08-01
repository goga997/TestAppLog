//
//  ViewController.swift
//  TestAppLog
//
//  Created by Grigore on 31.07.2023.
//

import UIKit

class FirstOnboardingViewController: UIViewController {

    let gradientLayer = Gradient.createLinearGradient()

    private lazy var firstImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "firstOnboarding")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleText = UILabel(text: "Welcome to Your App",
                                    font: .montserratBold26())
    private let descriptionText = UILabel(text: "Secure your data to be safe and Sound Anywhen and Anywhere",
                                          font: .montserratRegular14())
    
    private lazy var nextButton: UIButton = {
       let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .montserratRegular20()
        button.backgroundColor = #colorLiteral(red: 0.4100266099, green: 0.4064772129, blue: 0.9289067388, alpha: 1)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pageIndicatorView: PageIndicatorView = {
        let view = PageIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //MARK: - VC LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //width - 390; height - 844; iPhone 14

        gradientLayer.frame = view.bounds //for screen rotation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageIndicatorView.animationFirst()
    }
    
    //SetUpView
    private func setUpView() {
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(firstImageView)
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(pageIndicatorView)
        view.addSubview(nextButton)
    }
    
    @objc private func nextButtonTapped() {
        let secondVC = SecondOnboardingViewController()
        secondVC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(secondVC, animated: false, completion: nil)
    }

}


//MARK: - CONSTRAINTS
extension FirstOnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            firstImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27725), //234 points
            firstImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleText.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: 50),
            titleText.heightAnchor.constraint(equalToConstant: 30),
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 18),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            descriptionText.heightAnchor.constraint(equalToConstant: 35),

            pageIndicatorView.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: 180),
            pageIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageIndicatorView.heightAnchor.constraint(equalToConstant: 8),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.071) //60 points
        ])
    }
}
