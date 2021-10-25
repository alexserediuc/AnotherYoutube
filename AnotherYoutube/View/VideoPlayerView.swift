//
//  VideoPlayerView.swift
//  AnotherYoutube
//
//  Created by Alex on 22/10/2021.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    //DEMO DATA TO BE REPLACED
    let urlString = "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4"
    
    //MARK: - Private Properties
    private var player = AVPlayer()
    private var playerLayer = AVPlayerLayer()
    
    private var isMinimized = false
    private var isPlaying = false
    
    private var viewsToHide = [UIView]()
    lazy private var playerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy private var minimizeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.down")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleMinimize), for: .touchUpInside)
        viewsToHide.append(button)
        return button
    }()
    lazy private var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = UIColor.white
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    lazy private var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "pause.fill")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        viewsToHide.append(button)
        return button
    }()
    lazy private var videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        viewsToHide.append(label)
        return label
    }()
    lazy private var curretTimelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        viewsToHide.append(label)
        return label
    }()
    lazy private var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        let image = UIImage(named: "circle.fill")
        slider.setThumbImage(image, for: .normal)
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        viewsToHide.append(slider)
        return slider
    }()
    lazy private var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.isHidden = true
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Overriden Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isMinimized {
            setMiniConstraints()
        } else {
            setFullConstraints()
        }
        layoutIfNeeded()
        playerLayer.frame = playerContainer.bounds
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //player ready and going
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                if(seconds > 0){
                    let secondsText = Int(seconds) % 60
                    let minutesText = String(format: "%02d", Int(seconds) / 60)
                    videoLengthLabel.text = "\(minutesText):\(secondsText)"
                }
            }
        }
    }
    
    //MARK: - Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        let videoTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleVideoTap(sender:)))
        addGestureRecognizer(tapGesture)
        playerContainer.addGestureRecognizer(videoTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleClose), name: .closeOther, object: nil)
        setupLayout()
    }
    
    private func setupLayout() {
        setPlayer()
        showViews()
    }
    
    private func setPlayer() {
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerContainer.layer.addSublayer(playerLayer)
            player.play()
            
            player.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)
                self.curretTimelabel.text = "\(minutesString):\(secondsString)"
                //move the slider
                if let duration = self.player.currentItem?.duration {
                    let durationSconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds / durationSconds)
                }
            }
        }
    }
    
    private func setFullConstraints() {
        setFullContainer()
        setMinimizeButton()
        setActivityIndicator()
        setFullPausePlayButton()
        setCurrentTimeLabel()
        setVideoLengthLabel()
        setFullVideoSlider()
    }
    
    private func setMiniConstraints() {
        setMiniContainer()
        setMiniVideoSlider()
        setCloseButton()
        setMiniPausePlayButton()
    }
    
    private func setFullContainer() {
        addSubview(playerContainer)
        let constraints = [
            playerContainer.leftAnchor.constraint(equalTo: leftAnchor),
            playerContainer.rightAnchor.constraint(equalTo: rightAnchor),
            playerContainer.topAnchor.constraint(equalTo: topAnchor),
            playerContainer.heightAnchor.constraint(equalToConstant: frame.width * 9/16)
        ]
        activate(constraints: constraints)
    }
    
    private func setMiniContainer() {
        addSubview(playerContainer)
        let constraints = [
            playerContainer.leftAnchor.constraint(equalTo: leftAnchor),
            playerContainer.topAnchor.constraint(equalTo: topAnchor),
            playerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            playerContainer.widthAnchor.constraint(equalToConstant: frame.width/3)
        ]
        activate(constraints: constraints)
    }
    
    private func setMinimizeButton() {
        playerContainer.addSubview(minimizeButton)
        let constraints = [
            minimizeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            minimizeButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
        ]
        activate(constraints: constraints)
    }
    
    private func setActivityIndicator() {
        playerContainer.addSubview(activityIndicatorView)
        let constraints = [
            activityIndicatorView.centerYAnchor.constraint(equalTo: playerContainer.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: playerContainer.centerXAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setFullPausePlayButton() {
        pausePlayButton.tintColor = .white
        playerContainer.addSubview(pausePlayButton)
        let constraints = [
            pausePlayButton.centerYAnchor.constraint(equalTo: playerContainer.centerYAnchor),
            pausePlayButton.centerXAnchor.constraint(equalTo: playerContainer.centerXAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setCurrentTimeLabel() {
        playerContainer.addSubview(curretTimelabel)
        let constraints = [
            curretTimelabel.leftAnchor.constraint(equalTo: playerContainer.leftAnchor, constant: 8),
            curretTimelabel.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setVideoLengthLabel() {
        playerContainer.addSubview(videoLengthLabel)
        let constraints = [
            videoLengthLabel.rightAnchor.constraint(equalTo: playerContainer.rightAnchor, constant: -8),
            videoLengthLabel.centerYAnchor.constraint(equalTo: curretTimelabel.centerYAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setFullVideoSlider() {
        videoSlider.setThumbImage(UIImage(named: "circle.fill"), for: .normal)
        videoSlider.thumbTintColor = .red
        playerContainer.addSubview(videoSlider)
        let constraints = [
            videoSlider.leftAnchor.constraint(equalTo: curretTimelabel.rightAnchor),
            videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor),
            videoSlider.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor),
            videoSlider.centerYAnchor.constraint(equalTo: curretTimelabel.centerYAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setMiniVideoSlider() {
        videoSlider.setThumbImage(UIImage(), for: .normal)
        let constraints = [
            videoSlider.leftAnchor.constraint(equalTo: leftAnchor),
            videoSlider.rightAnchor.constraint(equalTo: rightAnchor),
            videoSlider.bottomAnchor.constraint(equalTo: playerContainer.bottomAnchor),
            videoSlider.heightAnchor.constraint(equalToConstant: 1)
        ]
        activate(constraints: constraints)
    }
    
    private func setMiniPausePlayButton() {
        pausePlayButton.isHidden = false
        pausePlayButton.tintColor = .darkGray
        addSubview(pausePlayButton)
        let constraints = [
            pausePlayButton.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -8),
            pausePlayButton.centerYAnchor.constraint(equalTo: playerContainer.centerYAnchor)
        ]
        activate(constraints: constraints)
    }
    
    private func setCloseButton() {
        closeButton.isHidden = false
        addSubview(closeButton)
        let constraints = [
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            closeButton.centerYAnchor.constraint(equalTo: playerContainer.centerYAnchor)
        ]
        activate(constraints: constraints)
    }
    
    @objc private func handleMinimize() {
        isMinimized = true
        clearConstraints()
        hideViews()
        
        NotificationCenter.default.post(name: .minimize, object: nil)
    }
    
    @objc private func handlePause() {
        if isPlaying {
            player.pause()
            pausePlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            pausePlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if isMinimized {
            maximize()
        }
    }
    
    @objc private func handleVideoTap(sender: UITapGestureRecognizer) {
        if isMinimized {
            maximize()
        } else {
            showViews()
        }
    }
    
    @objc func handleSliderChange() {
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player.seek(to: seekTime, completionHandler: { (completedSeek) in
                //do smth
            })
        }
    }
    
    @objc private func handleClose() {
        removeFromSuperview()
        player.pause()
        playerLayer.player = nil
        playerLayer.removeFromSuperlayer()
        NotificationCenter.default.post(name: .close, object: nil)
    }
    
    private func hideViews() {
        for v in viewsToHide {
            v.isHidden = true
        }
        if isMinimized {
            pausePlayButton.isHidden = false
            videoSlider.isHidden = false
        }
    }
    
    private func showViews() {
        for v in viewsToHide {
            v.isHidden = false
        }
        closeButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.hideViews()
        }
    }
    
    private func maximize() {
        isMinimized = false
        clearConstraints()
        showViews()
        NotificationCenter.default.post(name: .maximize, object: nil)
    }
}
