//
//  ModalViewController.swift
//  Drag to Dismiss
//
//  Created by Jason Chan on 29/6/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController, DragToDismiss {
    var interactor: Interactor?
    
    fileprivate lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewDidPan(_:)))
        return gesture
    }()
}

// MARK: Life Cycle

extension ModalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    override func loadView() {
        super.loadView()
        view.addSubview(dismissButton)
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.frame = CGRect(x: view.bounds.size.width - 100, y: 10, width: 100, height: 50)
    }
}

// MARK: Action

extension ModalViewController {
    func dismissButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    func viewDidPan(_ sender: UIPanGestureRecognizer) {
        drag(sender: sender, interactor: interactor, viewController: self)
    }
}

// MARK: UIGestureRecognizerDelegate

extension ModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
