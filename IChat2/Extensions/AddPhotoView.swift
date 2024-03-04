//
//  AddPhotoView.swift
//  IChat2
//
//  Created by user on 21/02/24.
//

import UIKit

class AddPhotoView: UIView {
    
    let circleImageView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "avatar")
        image.contentMode = .scaleAspectFit
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .buttonBlack()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circleImageView)
        addSubview(plusButton)
        setConstarins()
    }
    
    private func setConstarins() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleImageView.heightAnchor.constraint(equalToConstant: 100),
            circleImageView.widthAnchor.constraint(equalToConstant: 100),
            
            plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor,constant: 12),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
        circleImageView.clipsToBounds = true
    }
    
}
