//
//  ProfileViewController.swift
//  IChat2
//
//  Created by user on 27/02/24.
//


import UIKit

class ProfileViewController: UIViewController {
    
    let imageOfView = UIImageView(image: #imageLiteral(resourceName: "person7"), contentMode: .scaleAspectFill)
    let userLabel = UILabel(text: "Azam Niyazov", font: .apple20())
    let aboutMeLabel = UILabel(text: "I'm product manager in Balton and I'm a student of Finansial University in Tashkent", font: .systemFont(ofSize: 16, weight: .light))
    let myTextField = InsertableTextField()
    let containerView = UIView()
    
    private let user: MUser
    
    init(user: MUser) {
        self.user = user
        self.userLabel.text = user.username
        self.aboutMeLabel.text = user.description
        self.imageOfView.sd_setImage(with: URL(string: user.avatarStringURL))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        imageOfView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageOfView)
        view.addSubview(containerView)
        containerView.addSubview(userLabel)
        containerView.addSubview(aboutMeLabel)
        containerView.addSubview(myTextField)
        containerView.backgroundColor = .buttonWhite()
        containerView.layer.cornerRadius = 30
        aboutMeLabel.numberOfLines = 0
        
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc func sendButtonTapped() {
        print(#function)
        guard let message = myTextField.text, message != "" else { return }
        self.dismiss(animated: true) {
            FireStoreService.shared.createWaitingChat(message: message, receiver: self.user) { result in
                switch result {
                case .success():
                    self.showAlert(with: "Success!", and: "Your message for \(self.user.username) was delivered")
                case .failure(let error):
                    self.showAlert(with: "Error!", and: error.localizedDescription)
                }
            }
        }
        
    }
}

extension ProfileViewController {
    private func setConstrains() {

        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206),
            
            imageOfView.topAnchor.constraint(equalTo: view.topAnchor),
            imageOfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageOfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageOfView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            
            userLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            userLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            userLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            aboutMeLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            myTextField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            myTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}













// MARK: - SwiftUI canvas

import SwiftUI

struct ProfileProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let profileController = MainTabBarController()
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            profileController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
