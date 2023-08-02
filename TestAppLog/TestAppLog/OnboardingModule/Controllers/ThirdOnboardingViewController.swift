//
//  ThirdOnboardingViewController.swift
//  TestAppLog
//
//  Created by Grigore on 01.08.2023.
//

import UIKit

class ThirdOnboardingViewController: UIViewController {
    
    let gradientLayer = Gradient.createLinearGradient()
    
    private lazy var firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thirdOnboarding")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleText = UILabel(text: "Hide your Private Data",
                                    font: .montserratBold26())
    private let descriptionText = UILabel(text: "Manage your data personally!",
                                          font: .montserratRegular14())
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .montserratRegular20()
        button.backgroundColor = #colorLiteral(red: 0.4100266099, green: 0.4064772129, blue: 0.9289067388, alpha: 1)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
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
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.3) {
                self.pageIndicatorView.thirdIndicator.alpha = 1
                self.pageIndicatorView.secondIndicator.widthAnchor.constraint(equalToConstant: 17).isActive = true
                self.pageIndicatorView.firstIndicator.widthAnchor.constraint(equalToConstant: 17).isActive = true
                self.pageIndicatorView.thirdIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
                self.pageIndicatorView.secondIndicator.alpha = 0.2
                self.pageIndicatorView.firstIndicator.isHidden = false
            }
        }
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
    
    @objc private func startButtonTapped() {
        let setPassVC = SetPasswordViewController()
        setPassVC.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.6
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        
        present(setPassVC, animated: false, completion: nil)
    }
}

//MARK: - CONSTRAINTS
extension ThirdOnboardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            firstImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.27725), //234 points
            firstImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleText.topAnchor.constraint(equalTo: firstImageView.bottomAnchor, constant: 50),
            titleText.heightAnchor.constraint(equalToConstant: 70),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 7),
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
