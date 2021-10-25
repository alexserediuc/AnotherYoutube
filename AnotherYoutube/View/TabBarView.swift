//
//  TabBarView.swift
//  MyYoutube
//
//  Created by Alex on 13/10/2021.
//

import Foundation
import UIKit

class TabBarView: UIButton {
    
    var buttons = [UIButton]()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        let selectedImage = UIImage(systemName: "house.fill")
        let normalImage = UIImage(systemName: "house")
        button.tintColor = UIColor.darkGray
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.isSelected = true
    
        button.addTarget(self, action: #selector(homeTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func homeTouched() {
        print("File: \(#file), Function: \(#function), line: \(#line)")
        select(button: homeButton)
    }
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        let selectedImage = UIImage(systemName: "plus.circle.fill")
        let normalImage = UIImage(systemName: "plus.circle")
        button.tintColor = UIColor.darkGray
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        
        button.addTarget(self, action: #selector(addButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func addButtonTouched() {
        print("File: \(#file), Function: \(#function), line: \(#line)")
        select(button: addButton)
    }
    
    lazy var libraryButton: UIButton = {
        let button = UIButton()
        let selectedImage = UIImage(systemName: "folder.fill")
        let normalImage = UIImage(systemName: "folder")
        button.tintColor = UIColor.darkGray
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        
        button.addTarget(self, action: #selector(libraryTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func libraryTouched() {
        print("File: \(#file), Function: \(#function), line: \(#line)")
        select(button: libraryButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        buttons = [homeButton, addButton, libraryButton]
        setHomeConstraints()
        setAddConstraints()
        setLibraryConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pin(to superView: UIView) {
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor),
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setHomeConstraints() {
        addSubview(homeButton)
        NSLayoutConstraint.activate([
            homeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            homeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setAddConstraints() {
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setLibraryConstraints() {
        addSubview(libraryButton)
        NSLayoutConstraint.activate([
            libraryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            libraryButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func select(button: UIButton) {
        for b in buttons {
            if b == button {
                b.isSelected = true
            } else {
                b.isSelected = false
            }
        }
    }
}
