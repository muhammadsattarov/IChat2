//
//  AuthViewController.swift
//  IChat2
//
//  Created by user on 20/02/24.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"),contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let loginLabel = UILabel(text: "Already onboard?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonBlack())
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
    let signupVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        
    }
    
    private func setupViews() {
        googleButton.customizeGoogleLogo()
        view.backgroundColor = .systemBackground
        
        signupVC.delegate = self
        loginVC.delegate = self
        // Email button
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        // Login button
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func emailButtonTapped() {  // Email action button
        print(#function)
        present(signupVC, animated: true)
    }
    @objc private func loginButtonTapped() {  // Login action button
        print("\(#function) login1")
        present(loginVC, animated: true)
    }
    
}

// MARK: - Set constrains
extension AuthViewController {
    private func setConstrains() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: loginLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView],axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}

extension AuthViewController: AuthNavigationDelegate {
    func toSignUpVC() {
        present(signupVC, animated: true)
    }
    
    func toSignInVC() {
        present(loginVC, animated: true)
    }
    
    
}







//MARK: - SwiftUI canvas
import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = AuthViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

