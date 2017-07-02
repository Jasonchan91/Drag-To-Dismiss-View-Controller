//
//  DragToDismiss.swift
//  Drag to Dismiss
//
//  Created by Jason Chan on 30/6/17.
//  Copyright © 2017 Jason Chan. All rights reserved.
//

import UIKit

protocol DragToDismiss: class {
    var interactor: Interactor? { get }
}

extension DragToDismiss where Self: UIViewController {
    
    func drag(sender: UIPanGestureRecognizer, interactor: Interactor?, viewController: UIViewController, tableView: UITableView? = nil) {
        let threshold: CGFloat = 0.3
        let translation = sender.translation(in: viewController.view)
        let movement = fmax(0.0, translation.y / UIScreen.main.bounds.height)
        let movementPrecentage = fmin(movement, 1.0)
        
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            if let tableView = tableView {
                if tableView.contentOffset.y <= 0 {
                    interactor.hasStarted = true
                    viewController.dismiss(animated: true, completion: nil)
                }
            } else {
                interactor.hasStarted = true
                viewController.dismiss(animated: true, completion: nil)
            }
        case .changed:
            interactor.shouldFinish = movementPrecentage > threshold
            interactor.update(movementPrecentage)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
}

