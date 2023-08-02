//
//  SplashScreen.swift
//  TestAppLog
//
//  Created by Grigore on 02.08.2023.
//

import UIKit

class SplashScreen: UIViewController {
    
    let gradientLayer = Gradient.createLinearGradient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.navigateToMainApp()
        }
    }
    
    private func navigateToMainApp() {
        let mainVC = FirstOnboardingViewController()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
        
        sceneDelegate.window?.rootViewController = mainVC
    }
}
