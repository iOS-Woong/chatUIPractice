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
    }

    private func setupNavigation() {
        title = "Chat List"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

extension ViewController: UITableViewDelegate {
    
}
