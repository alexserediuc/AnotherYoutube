//
//  VideoCell.swift
//  MyYoutube
//
//  Created by Alex on 14/10/2021.
//

import UIKit

class VideoCell: UITableViewCell {
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var footerContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.darkGray
        imageView.layer.cornerRadius = frame.size.width/2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var detailsContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static func getIdentifier() -> String{
        return "VideoCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setThumbnailConstraints()
        setFooterContainerConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(video: Video) {
        //TODO: thumbnail fetch based on vid
        thumbnailImageView.image = UIImage(named: "thumbnailPlaceholder")
        //TODO: profile fetch based on uid
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        videoTitleLabel.text = video.title
        usernameLabel.text = video.user.username
        
        //TODO: method to get shorter versions
        let views = String(video.viewsNumber)
        viewsLabel.text = "\u{2022} \(views) views"
        
        //TODO: method for youtube like date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        dateLabel.text = "\u{2022} \(dateFormatter.string(from: video.uploadDate))"
    }
    
    func setThumbnailConstraints() {
        addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor),
            thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 9/16),
        ])
        
    }
    
    func setFooterContainerConstraints() {
        addSubview(footerContainerView)
        NSLayoutConstraint.activate([
            footerContainerView.rightAnchor.constraint(equalTo: rightAnchor),
            footerContainerView.leftAnchor.constraint(equalTo: leftAnchor),
            footerContainerView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor),
            footerContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setProfileImageConstraints()
        setDetailsContainerConstraints()
    }
    
    func setProfileImageConstraints() {
        footerContainerView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            profileImageView.centerYAnchor.constraint(equalTo: footerContainerView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setDetailsContainerConstraints() {
        footerContainerView.addSubview(detailsContainerView)
        NSLayoutConstraint.activate([
            detailsContainerView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
            detailsContainerView.centerYAnchor.constraint(equalTo: footerContainerView.centerYAnchor),
            detailsContainerView.rightAnchor.constraint(equalTo: footerContainerView.rightAnchor),
            detailsContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setVideoTitleConstraints()
        setUsernameConstraints()
        setViewsConstrainst()
        setDateConstraints()
    }
    
    func setVideoTitleConstraints() {
        detailsContainerView.addSubview(videoTitleLabel)
        NSLayoutConstraint.activate([
            videoTitleLabel.leftAnchor.constraint(equalTo: detailsContainerView.leftAnchor),
            videoTitleLabel.rightAnchor.constraint(equalTo: detailsContainerView.rightAnchor),
            videoTitleLabel.topAnchor.constraint(equalTo: detailsContainerView.topAnchor)
        ])
    }
    
    func setUsernameConstraints() {
        detailsContainerView.addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.leftAnchor.constraint(equalTo: detailsContainerView.leftAnchor),
            usernameLabel.topAnchor.constraint(equalTo: videoTitleLabel.bottomAnchor)
        ])
    }
    
    func setViewsConstrainst() {
        detailsContainerView.addSubview(viewsLabel)
        NSLayoutConstraint.activate([
            viewsLabel.leftAnchor.constraint(equalTo: usernameLabel.rightAnchor, constant: 5),
            viewsLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor)
        ])
    }
    
    func setDateConstraints() {
        detailsContainerView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: viewsLabel.rightAnchor, constant: 5),
            dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor)
        ])
    }
    
    func setTitleLabelConstraints() {
        videoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            videoTitleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 20),
            videoTitleLabel.heightAnchor.constraint(equalToConstant: 80),
            videoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
