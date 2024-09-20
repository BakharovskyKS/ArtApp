//
//  MainTableViewController.swift
//  ArtApp
//
//  Created by Кирилл Бахаровский on 9/21/24.
//

import UIKit

class AuthorsTableViewController: UIViewController{
    
    var url = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
    var authors: [Artist] = []
    
    private let idTableViewCell = "AuthorTableViewCell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        view.backgroundColor = .white
        
        NetworkingManager.shared.fetchData(from: url) { artists in
            guard let artists = artists else { return }
            self.authors = artists
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        setupViews()
        setConstraints()
        setDelegate()
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
        
    }
    
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}



extension AuthorsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? AuthorTableViewCell else {
            return UITableViewCell() }
        
        let artist = authors[indexPath.row]
        cell.configure(artist: artist)
        return cell
    }
}

extension AuthorsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension AuthorsTableViewController {
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            
        ])
    }
}
