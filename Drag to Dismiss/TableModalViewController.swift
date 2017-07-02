//
//  TableModalViewController.swift
//  InteractiveModal
//
//  Created by Jason Chan on 30/6/17.
//  Copyright © 2017 Thorn Technologies. All rights reserved.
//

import UIKit

class TableModalViewController: UIViewController, DragToDismiss {
    
    var interactor: Interactor?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: String(describing: CustomCell.self))
        return tableView
    }()
    
    fileprivate lazy var panGesture: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewDidPan(_:)))
        gesture.delegate = self
        return gesture
    }()

}

// MARK: Life Cycle

extension TableModalViewController {
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        tableView.addGestureRecognizer(panGesture)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonDidTap))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Action

extension TableModalViewController {
    func dismissButtonDidTap() {
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewDidPan(_ sender: UIPanGestureRecognizer) {
        drag(sender: sender, interactor: interactor, viewController: self, tableView: tableView)
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension TableModalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomCell.self), for: indexPath) as? CustomCell else { return UITableViewCell() }
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ModalViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension TableModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

class CustomCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
