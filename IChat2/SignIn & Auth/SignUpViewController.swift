//
//  SignUpViewController.swift
//  IChat2
//
//  Created by user on 20/02/24.
//

import UIKit

protocol AuthNavigationDelegate: AnyObject {
    func toSignUpVC()
    func toSignInVC()
}

class SignUpViewController: UIViewController {
    
    // labels, textFields, buttons
    let welcomeLabel = UILabel(text: "Good to see you", font: .apple26())
    
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm Password")
    let alreadyOnboarLabel = UILabel(text: "Already onboard?")
    
    let emailTextFieald = OneLineTextField(font: .apple20())
    let passwordTextFieald = OneLineTextField(font: .apple20())
    let confirmPasswordTextFieald = OneLineTextField(font: .apple20())

    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonBlack())
    let signInButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.setTitleColor(.buttonRed(), for: .normal)
        return loginButton
    }()
    
    weak var delegate: AuthNavigationDelegate?
    
    // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstrains()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

    }
    
    // MARK: - Actions
    @objc private func signUpButtonTapped() {
        print(#function)
        AuthService.shared.register(email: emailTextFieald.text,
                                    password: passwordTextFieald.text,
                                    confirmPassword: confirmPasswordTextFieald.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Success!", and: "You are register") {
                    self.present(SetupProfileViewController(currentUser: user), animated: true)
                }
                print(user.email ?? "no email")
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func signInButtonTapped() {
        print(#function)
        dismiss(animated: true) {
            self.delegate?.toSignInVC()
        }
    }
}

// MARK: - Set constrains

extension SignUpViewController {
    private func setConstrains() {
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextFieald],
                                         axis: .vertical,
                                         spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextFieald],
                                            axis: .vertical,
                                            spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTextFieald],
                                                   axis: .vertical,
                                                   spacing: 0)
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboarLabel, signInButton],
                                          axis: .horizontal,
                                          spacing: 10)
        bottomStackView.alignment = .firstBaseline
        let stackView = UIStackView(arrangedSubviews: [emailStackView,
                                                      passwordStackView,
                                                      confirmPasswordStackView,
                                                      signUpButton],
                                    axis: .vertical,
                                    spacing: 40)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.size.width / 3),
            
        ])
    }
}













// MARK: - SwiftUI canvas

import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let signUpViewController = SignUpViewController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            signUpViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
