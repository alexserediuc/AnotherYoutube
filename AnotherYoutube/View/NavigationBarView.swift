//
//  NavigationBarView.swift
//  MyYoutube
//
//  Created by Alex on 13/10/2021.
//

import Foundation
import UIKit

class NavigationBarView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "person.circle.fill")
        button.tintColor = UIColor.darkGray
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    @objc func profileTapped() {
        print("Tapped profile")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setLogoImageConstraints()
        setProfileButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLogoImageConstraints() {
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor),
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
    }
    
    func pin(to superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor),
            leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor),
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setProfileButtonConstraints() {
        addSubview(profileButton)
        NSLayoutConstraint.activate([
            profileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
