//
//  UIViewExtensions.swift
//  AnotherYoutube
//
//  Created by Alex on 22/10/2021.
//

import Foundation
import UIKit

extension UIView {
    
    private static var customConstraints = [NSLayoutConstraint]()
    
    func activate(constraints: [NSLayoutConstraint]) {
        UIView.customConstraints.append(contentsOf: constraints)
        UIView.customConstraints.forEach { $0.isActive = true }
    }
    
    func clearConstraints() {
        UIView.customConstraints.forEach { $0.isActive = false }
        UIView.customConstraints.removeAll()
    }    
}
