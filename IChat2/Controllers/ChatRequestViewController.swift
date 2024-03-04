//
//  ChatRequestView.swift
//  IChat2
//
//  Created by user on 27/02/24.
//


import UIKit

class ChatRequestViewController: UIViewController {
    
    lazy var imageOfView = UIImageView(image: #imageLiteral(resourceName: "person7"), contentMode: .scaleAspectFill)
    lazy var containerView = UIView()
    lazy var nameLabel = UILabel(text: "Aida Sagindikova", font: .apple20())
    lazy var aboutMeLabel = UILabel(text: "I'm product manager in Balton and I'm a student of Finansial University in Tashkent", font: .systemFont(ofSize: 16, weight: .light))
    lazy var accentButton = UIButton(title: "Accent", titleColor: .white, backgroundColor: .black, font: .apple20(), isShadow: false, cornerRadius: 10)
    lazy var denyButton = UIButton(title: "Deny", titleColor: .red, backgroundColor: .white, font: .apple20(), isShadow: false, cornerRadius: 10)
    
    private var chat: MChat
    
    init(chat: MChat) {
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        self.nameLabel.text = chat.friendUserName
        self.imageOfView.sd_setImage(with: URL(string: chat.friendUserImageString))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstrains()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.accentButton.applyGradients(cornerRadius: 10)

    }
    
    private func setupViews() {
       
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = UIColor.red.cgColor
        containerView.backgroundColor = .buttonWhite()
        containerView.layer.cornerRadius = 30
        aboutMeLabel.numberOfLines = 0
        
        view.addSubview(imageOfView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutMeLabel)
        
        imageOfView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ChatRequestViewController {
    private func setConstrains() {
        let buttonsStackView = UIStackView(arrangedSubviews: [accentButton,
                                                              denyButton],
                                           axis: .horizontal,
                                           spacing: 7)
            buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
            buttonsStackView.distribution = .fillEqually
            containerView.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 206),
            
            imageOfView.topAnchor.constraint(equalTo: view.topAnchor),
            imageOfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageOfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageOfView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            buttonsStackView.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}











