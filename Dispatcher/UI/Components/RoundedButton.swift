//
//  CustomButton.swift
//  Dispatcher
//
//  Created by Hadar Basson on 28/08/2023.
//

import UIKit

class RoundedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        widthAnchor.constraint(equalToConstant: 335).isActive = true
        heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        backgroundColor = .blue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    func setButtonColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func setButtonTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
}

