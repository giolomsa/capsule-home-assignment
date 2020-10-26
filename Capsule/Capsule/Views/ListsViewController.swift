//
//  ViewController.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/20/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class ListsViewController: UIViewController {
    
    // MARK: local variables/constants
    private let tableView = UITableView()
    private let viewModel = ListsViewModel()
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        title = "Best Sellers list"
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewFromViewModel), name: ListsViewModel.listsSetNotification, object: nil)
        showActivity()
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getBestSellerLists()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: Local methods
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func updateViewFromViewModel(){
        DispatchQueue.main.async {
            self.stopActivity()
            self.tableView.reloadData()
            print(self.viewModel.lists.count)
        }        
    }

    private func didSelectList(list: List){
        let listDetailsViewController = ListDetailsViewController()
        listDetailsViewController.currentList = list
        self.navigationController?.pushViewController(listDetailsViewController, animated: true)
    }
    
}

extension ListsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.viewModel.lists[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedList = viewModel.lists[indexPath.row]
        
        didSelectList(list: selectedList)
    }
    
}
