//
//  VideoChannelView.swift
//  AnotherYoutube
//
//  Created by Alex on 26/10/2021.
//

import UIKit

class VideoChannelView: UIView {

    //MARK: - Private Properties
    private var user: User?
    
    lazy private var channelPhoto: UIImageView = {
       let imageView = UIImageView()
        let image = UIImage(systemName: "person.circle.fill")
        imageView.image = image
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy private var channelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy private var channelSubscribers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy private var subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("SUBSCRIBE", for: .normal)
        button.addTarget(self, action: #selector(subscribeTouched), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.addArrangedSubview(channelName)
        stackView.addArrangedSubview(channelSubscribers)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Overriden Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBorders()
        let constraints = [
            channelPhoto.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            channelPhoto.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: channelPhoto.rightAnchor, constant: 10),
            
            subscribeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            subscribeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        activate(constraints: constraints)
    }
    
    //MARK: - Public Methods
    public func set(user: User) {
        print(user)
        //Dummy data
        channelName.text = user.username
        channelSubscribers.text = "100k subscribers"
    }
    
    //MARK: - Private Methods
    private func setupLayout() {
        addSubview(channelPhoto)
        addSubview(stackView)
        addSubview(subscribeButton)
        
        
    }
    
    private func setBorders() {
        let topBorder = CALayer()
        topBorder.borderColor = UIColor.darkGray.cgColor
        topBorder.borderWidth = 1;
        topBorder.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
        layer.addSublayer(topBorder)

        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.darkGray.cgColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 1)
        layer.addSublayer(bottomBorder)
    }
    
    @objc private func subscribeTouched() {
        print("File: \(#file), Function: \(#function), line: \(#line)")
    }
}
