//
//  WaitingChatsCell.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import UIKit

class WaitingChatsCell: UICollectionViewCell, SelfConfigureCell {
    static var reuseId: String = "WaitingChatsCell"
    
    let imageOfView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray2
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setConstrains()
    }
    
    func configure(with value: MChat) {
        imageOfView.image = UIImage(named: value.userImageString)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstrains() {
        self.addSubview(imageOfView)
        imageOfView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageOfView.topAnchor.constraint(equalTo: self.topAnchor),
            imageOfView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageOfView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageOfView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
