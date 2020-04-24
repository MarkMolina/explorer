//
//  MyLocationButton.swift
//  spotter
//
//  Created by Mark Anthony Molina on 24/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import UIKit

let BUTTON_WIDTH: CGFloat = 70.0
let BUTTON_HEIGHT: CGFloat = BUTTON_WIDTH

class MyLocationButton: UIButton {
    
    init() {
        super.init(frame: CGRect.null)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage.init(named: "myLocation"), for: .normal)
        backgroundColor = UIColor.white
        layer.cornerRadius = BUTTON_HEIGHT / 2
        layer.borderWidth = 2
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
    }
    
    private func layout() {
        
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: BUTTON_WIDTH),
            self.heightAnchor.constraint(equalToConstant: BUTTON_HEIGHT)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
