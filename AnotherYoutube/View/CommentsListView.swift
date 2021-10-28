//
//  CommentsListView.swift
//  AnotherYoutube
//
//  Created by Alex on 28/10/2021.
//

import UIKit

class CommentsListView: UIView {

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        print("close button tapped")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    init(with comments: [Comment]) {
        let screenBounds = UIScreen.main.bounds
        let startingFrame = CGRect(x: screenBounds.minX, y: screenBounds.maxY, width: screenBounds.width, height: 10)
        print(startingFrame)
        super.init(frame: startingFrame)
        
        translatesAutoresizingMaskIntoConstraints = false
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("CommentsListView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}


