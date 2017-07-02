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
    
    fileprivate lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Normal View", for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(showButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var showTableButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Table View", for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(showButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: Life Cycle

extension ViewController {
    override func loadView() {
        super.loadView()
        view.addSubview(showButton)
        view.addSubview(showTableButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showButton.frame = CGRect(x: view.bounds.size.width / 2 - 70 , y: view.bounds.size.height / 2 - 25, width: 150, height: 50)
        showTableButton.frame = CGRect(x: view.bounds.size.width / 2 - 70 , y: view.bounds.size.height / 2 + 50, width: 150, height: 50)
    }
}

// MARK: Action

extension ViewController {
    func showButtonDidTap(_ sender: UIButton) {
        if sender.tag == 0 {
            let viewController = ModalViewController()
            viewController.transitioningDelegate = self
            viewController.interactor = interactor
            present(viewController, animated: true, completion: nil)
        } else {
            let viewController = TableModalViewController()
            //        viewController.transitioningDelegate = self
            viewController.interactor = interactor
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.transitioningDelegate = self
            self.present(navigationController, animated: true, completion: nil)
        }
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

