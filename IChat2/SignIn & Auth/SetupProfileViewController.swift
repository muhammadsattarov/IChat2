//
//  SetupProfileViewController.swift
//  IChat2
//
//  Created by user on 20/02/24.
//


import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    let addphotoView = AddPhotoView()
    
    let welcomeLabel = UILabel(text: "Set up Profile!", font: .apple26())
    
    let fullnameLabel = UILabel(text: "Fullname")
    let aboutLabel = UILabel(text: "About me")
    let genderLabel = UILabel(text: "Gender")
    
    let fullNameTextField = OneLineTextField(font: .apple20())
    let aboutMeTextFieald = OneLineTextField(font: .apple20())
    let genderSegmentedControl = UISegmentedControl(first: "Male", second: "Famale")
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack())
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            fullNameTextField.text = username
            
            if let photoURL = currentUser.photoURL {
                addphotoView.circleImageView.sd_setImage(with: photoURL)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setConstrains()
        // Goto chats button
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        // plusButton
        addphotoView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
// MARK: - Actions
    @objc private func plusButtonTapped() {
        print(#function)
    let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @objc private func goToChatsButtonTapped() {  // Goto chats action button
        print(#function)
        FireStoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                username: fullNameTextField.text,
                                                avatarImage: addphotoView.circleImageView.image,
                                                description: aboutMeTextFieald.text,
                                                gender: genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let muser):
                self.showAlert(with: "Success", and: "We wish you a pleasant conversation") {
                    let mainTabBar = MainTabBarController(currentUser: muser)
                    mainTabBar.modalPresentationStyle = .fullScreen
                    self.present(mainTabBar, animated: true)
                }
                print(muser)
            case .failure(let error):
                self.showAlert(with: "Error", and: error.localizedDescription)
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        addphotoView.circleImageView.image = image
    }
}

// MARK: - Set constrains
extension SetupProfileViewController {
    private func setConstrains() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullnameLabel,
                                                              fullNameTextField],
                                            axis: .vertical,
                                            spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutLabel,
                                                             aboutMeTextFieald],
                                           axis: .vertical,
                                           spacing: 0)
        let genderStackView = UIStackView(arrangedSubviews: [genderLabel,
                                                            genderSegmentedControl],
                                          axis: .vertical,
                                          spacing: 12)
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [fullNameStackView,
                                                      aboutMeStackView,
                                                      genderStackView,
                                                      goToChatsButton],
                                    axis: .vertical,
                                    spacing: 40)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        addphotoView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(addphotoView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            addphotoView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            addphotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addphotoView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}




// MARK: - SwiftUI canvas

import SwiftUI

struct SetupProfileVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let setupProfileController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        
        func makeUIViewController(context: Context) -> some UIViewController {
            setupProfileController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

