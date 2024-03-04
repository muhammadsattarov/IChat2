//
//  SelfConfigureCell.swift
//  IChat2
//
//  Created by user on 27/02/24.
//

import Foundation


protocol SelfConfigureCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
