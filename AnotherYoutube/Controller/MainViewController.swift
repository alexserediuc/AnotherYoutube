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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        setViews()
    }
    
    //MARK: - Private Methods
    private func setViews() {
        view.addSubview(navigationBarView)
        view.addSubview(tabBarView)
        
        navigationBarView.pin(to: view)
        tabBarView.pin(to: view)
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
        NotificationCenter.default.post(name: .closeOtherVideoPlayer, object: nil)
        let startingFrame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 10)
        videoView = VideoPlayerView(frame: startingFrame, video: videos[indexPath.row])
        setFullVideoConstraints()
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

