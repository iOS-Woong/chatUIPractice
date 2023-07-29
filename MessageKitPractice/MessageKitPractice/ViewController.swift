//
//  ViewController.swift
//  MessageKitPractice
//
//  Created by 서현웅 on 2023/07/30.
//

import UIKit

class ViewController: UIViewController {

    private let chatListTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableViewAttributes()
        setupViews()
    }

    private func setupNavigation() {
        title = "Chat List"
    }
    
    private func setupTableViewAttributes() {
        chatListTableView.dataSource = self
        chatListTableView.delegate = self
    }
    
    private func setupViews() {
        chatListTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(chatListTableView)
        
        NSLayoutConstraint.activate([
            chatListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            chatListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "John"
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ChatViewController()
        vc.title = "Person XX"
        navigationController?.pushViewController(vc, animated: true)
    }
}
