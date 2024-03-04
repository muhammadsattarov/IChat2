//
//  LoginViewController.swift
//  IChat2
//
//  Created by user on 20/02/24.
//

import UIKit


class LoginViewController: UIViewController {
    
    // Labels, TextFields, buttons
    let welcomeBackLabel = UILabel(text: "Welcome Back", font: .apple26())
    
    let loginWithLabel = UILabel(text: "Login With")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack())
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        return button
    }()
    
    let emailTextFieald = OneLineTextField(font: .apple20())
    let passwordTextFieald = OneLineTextField(font: .apple20())
    
    weak var delegate: AuthNavigationDelegate?
    
// MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        googleButton.customizeGoogleLogo()
        view.backgroundColor = .systemBackground
        setConstrains()
        
        loginButton.addTarget(self, action: #selector(LoginButtonTapped), for: .touchUpInside)  // Login button
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)  // signUp button
    }
    
// MARK: - Actions
    @objc private func LoginButtonTapped() {  // Login action button
        print("\(#function) login2")
        AuthService.shared.login(email: emailTextFieald.text!,
                                 password: passwordTextFieald.text!) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Success", and: "you are registered") {
                    FireStoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let muser):
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            self.present(mainTabBar, animated: true)
                        case .failure(let error):
                            self.present(SetupProfileViewController(currentUser: user), animated: true)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func signUpButtonTapped() {  // signUp action button
        print("\(#function) login")
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
}

// MARK: - Set constrains

extension LoginViewController {
    private func setConstrains() {
        let loginWithStackView = ButtonFormView(label: loginWithLabel, button: googleButton)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel,
                                                            emailTextFieald],
                                         axis: .vertical,
                                         spacing: 0)
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,
                                                               passwordTextFieald],
                                            axis: .vertical,
                                            spacing: 0)
        
        let stackView = UIStackView(arrangedSubviews: [loginWithStackView,
                                                       orLabel,
                                                      emailStackView,
                                                      passwordStackView,
                                                       loginButton],
                                    axis: .vertical,
                                    spacing: 40)
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel,
                                                            signUpButton],
                                          axis: .horizontal,
                                          spacing: 4)
       
        welcomeBackLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeBackLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: welcomeBackLabel.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width / 3),
        ])
        
    }
}














// MARK: - SwiftUI canvas

import SwiftUI

struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let loginViewController = LoginViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            loginViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
