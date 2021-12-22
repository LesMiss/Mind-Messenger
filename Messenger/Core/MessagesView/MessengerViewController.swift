//
//  MesViewController.swift
//  Messenger
//
//  Created by Migel Lestev on 08.12.2021.
//

import UIKit
import Firebase

protocol MessengerViewProtocol: class {
    var users: [User] { get set }
    func getName(name: String) -> Void
}

class MessengerViewController: UITableViewController {
    
    // properties
    var presenter: MessengerPresentation?
    var refresh = UIRefreshControl()
    var users = [User]()
    
    // ui
    lazy var imageNotInternet = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureToImageNotInternet()
        presenter?.viewDidLoad()
        configureRefresh()
        configureTableView()
        addingUsersInTableView()
    }
    
    
    // configure UI
    private func configureToImageNotInternet() {
        // settings ImageNotInternet
        imageNotInternet.image = UIImage(named: "error-404")
        imageNotInternet.clipsToBounds = true
        imageNotInternet.contentMode = .scaleAspectFill
        imageNotInternet.isHidden = true

        //constaraints to ImageNotInternet
        view.addSubview(imageNotInternet)
        imageNotInternet.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(62)
            make.height.equalTo(62)
        }
    }
    
    private func configureTableView() {
        // view
        view.backgroundColor = .secondarySystemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Signout", style: .plain, target: self, action: #selector(signOut))
        // table view
        tableView.refreshControl = refresh
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        tableView.register(UsersCell.self, forCellReuseIdentifier: "cellID")
    }
    
    //MARK: Needed methods ->
    private func configureRefresh() {
        refresh.tintColor = .dynamic
        refresh.addTarget(self, action: #selector(updateTableView), for: .valueChanged)
    }
    
    private func addingUsersInTableView() {
        users.removeAll()
        presenter?.extractUsers()
        tableView.reloadData()
    }
    
    @objc func updateTableView() {
        self.addingUsersInTableView()
        DispatchQueue.main.async { [ weak self ] in
            guard let `self` = self else { return }
            self.refresh.endRefreshing()
        }
    }
    
    @objc func signOut() {
        presenter?.signOut()
    }
    
}

extension MessengerViewController: MessengerViewProtocol {
    
    func getName(name: String) {
        title = name
    }
    
    //MARK: Configure TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! UsersCell
        
        cell.title.text = users[indexPath.row].name
        cell.imgView.image = users[indexPath.row].avatar
        cell.imgView.layer.cornerRadius = cell.imgView.bounds.width / 2
        
        presenter?.deletingCurrentUserInTableView(indexPath: indexPath) {
            tableView.reloadData()
        }
        
        cell.backgroundColor = .tertiarySystemFill
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatView = ChatAssembly.chatModuleBuilder() as! ChatViewController
        navigationController?.pushViewController(chatView, animated: true)
        chatView.user = users[indexPath.row]
    }
}
