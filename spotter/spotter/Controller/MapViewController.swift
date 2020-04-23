//
//  MapViewController.swift
//  spotter
//
//  Created by Mark Anthony Molina on 23/04/2020.
//  Copyright © 2020 dakke dak. All rights reserved.
//

import UIKit
import GoogleMaps

// MARK: - State
private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

private let MENU_CLOSED_OFFSET: CGFloat = 80
private let MENU_OPEN_OFFSET: CGFloat = 440

class MapViewController: UIViewController {
    
    private var currentState: State = .closed
    private var bottomConstraint: NSLayoutConstraint?
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(menuTapped(recognizer:)))
        return recognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let mapView = GMSMapView(frame: view.frame)
        view.addSubview(mapView)
        
        let menuViewController = MenuViewController()
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menuViewController.view)
        
        bottomConstraint = menuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: closedOffset())
        let constraints = [
            menuViewController.view.heightAnchor.constraint(equalToConstant: view.frame.height),
            menuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomConstraint!,
            menuViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        menuViewController.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func menuTapped(recognizer: UITapGestureRecognizer) {
        
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: { [weak self] in
            
            guard let `self` = self else { return }
            
            switch state {
            case .open:
                self.bottomConstraint?.constant = MENU_OPEN_OFFSET
            case .closed:
                self.bottomConstraint?.constant = self.closedOffset()
            }
            self.view.layoutIfNeeded()
        })
        
        transitionAnimator.addCompletion { [weak self] position in
            
            guard let `self` = self else { return }
            
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                print("Unknown state")
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint?.constant = MENU_OPEN_OFFSET
            case .closed:
                self.bottomConstraint?.constant = self.closedOffset()
            }
        }
        transitionAnimator.startAnimation()
    }
    
    private func closedOffset() -> CGFloat {
        return view.frame.height - MENU_CLOSED_OFFSET
    }
}
