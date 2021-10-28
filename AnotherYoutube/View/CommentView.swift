//
//  CommentsView.swift
//  AnotherYoutube
//
//  Created by Alex on 28/10/2021.
//

import UIKit

class CommentView: UIView {
    @IBOutlet weak var commentsNumbersLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("comments layout")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender: )))
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewTapped(sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .extendComments, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(commentsNumber: String, comment: String) {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        commonInit()
        commentsNumbersLabel.text = commentsNumber
        commentLabel.text = comment
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("CommentView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
