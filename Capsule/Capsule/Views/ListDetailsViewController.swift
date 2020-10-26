//
//  ListDetailsViewController.swift
//  Capsule
//
//  Created by Gio Lomsa on 10/23/20.
//  Copyright © 2020 Giorgi Lomsadze. All rights reserved.
//

import UIKit

class ListDetailsViewController: UIViewController {
    
    // MARK: local variables/constants
    private let cellId = "bookcellid"
    private let tableView = UITableView()
    private let viewModel = ListsViewModel()
    var currentList: List?
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = currentList else {showErrorAllert(); return }
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViewFromViewModel), name: ListsViewModel.listDetailsSetNotification, object: nil)
        showActivity()
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getListDetails(date: self.currentList?.newestPublishDate ?? "", list: self.currentList?.encodedName ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Local methods
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        tableView.register(BookCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    @objc private func updateViewFromViewModel(){
        DispatchQueue.main.async {
            if let selectedList = self.viewModel.selectedList{
                let headerView = TableViewHeaderView(list: selectedList, width: self.view.frame.width)
                headerView.translatesAutoresizingMaskIntoConstraints = false
                self.tableView.tableHeaderView = headerView
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
            
            self.stopActivity()
            self.tableView.reloadData()
        }
    }
    
    private func showErrorAllert(){
        showSimpleAlert(title: "Something went wrong", message: "Something went wrong on our side, please try again.")
    }
    
    func openBuyBookPage(link: String){
        let buyBookViewController = BuyBookViewController()
        buyBookViewController.urlString = link
        self.present(buyBookViewController, animated: true, completion: nil)
    }
}

extension ListDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.selectedList?.books?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let currentBook = self.viewModel.selectedList?.books?[indexPath.row], let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BookCell{
            cell.configure(book: currentBook)
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ListDetailsViewController: BookCellDelegate{
    func didSelectBuyBook(book: Book) {
        self.showBuyBookAlert(title: "Buy \(book.title)", message: "Please select the option", buyLinks: book.buyLinks)
        print(book.title)
    }
}
