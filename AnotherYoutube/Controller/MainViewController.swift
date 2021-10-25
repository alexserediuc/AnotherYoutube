//
//  ViewController.swift
//  AnotherYoutube
//
//  Created by Alex on 22/10/2021.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: - Private Properties
    lazy private var navigationBarView = NavigationBarView()
    lazy private var tabBarView = TabBarView()
    lazy private var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = view.frame.width * 9/16 + 75
        tableView.separatorStyle = .none
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.getIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy private var videoPlayerView = VideoPlayerView()
    private var videos: [Video] = []
    
    //MARK: - Overriden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setTableDelegates()
        fetchData()
        setNotifications()
    }

    //MARK: - Private Methods
    private func setViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(navigationBarView)
        view.addSubview(tabBarView)
        view.addSubview(videosTableView)
        
        navigationBarView.pin(to: view)
        tabBarView.pin(to: view)
        NSLayoutConstraint.activate([
            videosTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            videosTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            videosTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor)
        ])
    }
    
    private func setTableDelegates() {
        videosTableView.delegate = self
        videosTableView.dataSource = self
    }
    
    private func fetchData() {
        videos = fetchDummyVideos()
    }
    
    private func setNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(minimizeVideoPlayer), name: .minimize, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(maximizeVideoPlayer), name: .maximize, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeVideoPlayer), name: .close, object: nil)
    }
    
    @objc private func maximizeVideoPlayer() {
        let constraints = [
            videoPlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            videoPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            videoPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        view.activate(constraints: constraints)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func minimizeVideoPlayer() {
        let constraints = [
            videoPlayerView.heightAnchor.constraint(equalToConstant: view.frame.width/3 * 9/16),
            videoPlayerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            videoPlayerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            videoPlayerView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor)
        ]
        view.activate(constraints: constraints)
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func closeVideoPlayer() {
        videoPlayerView.removeFromSuperview()
        view.clearConstraints()
        NSLayoutConstraint.activate([
            videosTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            videosTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            videosTableView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor)
        ])
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func launchVideoPlayer() {
        //TODO: launch with video url from data model
        let startingFrame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 10)
        videoPlayerView = VideoPlayerView(frame: startingFrame)
        view.addSubview(videoPlayerView)
    }
    
    private func closeOtherPlayer() {
        NotificationCenter.default.post(name: .closeOther, object: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.getIdentifier()) as! VideoCell
        let video = videos[indexPath.row]
        cell.set(video: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeOtherPlayer()
        launchVideoPlayer()
        maximizeVideoPlayer()
    }
}

extension MainViewController {
    func fetchDummyVideos() -> [Video] {
        let user = User(uid: "123", username: "Georgel")
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 7
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponents)
        let video1 = Video(vid: "1234", title: "Ceva titluuuuuuuuuuuuu uuuuuu uuuuuuuuuu", viewsNumber: 1000, uploadDate: someDate!, user: user)
        let video2 = Video(vid: "123", title: "Ceva titlu 2", viewsNumber: 10000, uploadDate: someDate!, user: user)
        return [video1,video2,video1,video2]
    }
}
