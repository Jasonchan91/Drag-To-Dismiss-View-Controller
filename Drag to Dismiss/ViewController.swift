//
//  ViewController.swift
//  Drag to Dismiss
//
//  Created by Jason Chan on 29/6/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let interactor = Interactor()
    
    fileprivate lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show", for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidTapped), for: .touchUpInside)
        return button
    }()
}

// MARK: Life Cycle

extension ViewController {
    override func loadView() {
        super.loadView()
        view.addSubview(closeButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.bounds.size.width / 2 - 50 , y: view.bounds.size.height / 2 - 25, width: 100, height: 50)
    }
}

// MARK: Action

extension ViewController {
    func closeButtonDidTapped() {
        let viewController = TableModalViewController()
        //        viewController.transitioningDelegate = self
        viewController.interactor = interactor
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.transitioningDelegate = self
        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: UIViewControllerTransitioningDelegate

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

