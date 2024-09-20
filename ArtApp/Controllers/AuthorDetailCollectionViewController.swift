//
//  AuthorDetailTableViewController.swift
//  ArtApp
//
//  Created by Кирилл Бахаровский on 9/21/24.
//

import UIKit

class AuthorDetailCollectionViewController: UIViewController {
    
    var url = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
    var work: [Work] = []
    
    private let idTableViewCell = "AuthorTableViewCell"
    
    private let tableView: UICollectionView = {
        let tableView = UICollectionView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.layer.cornerRadius = 10
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
        
        setupViews()
        setConstraints()
        setDelegate()
        tableView.register(AuthorTableViewCell.self, forCellWithReuseIdentifier: idTableViewCell)
    }
    
    private func setDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}



extension AuthorDetailCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return work.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AuthorDetailCollectionViewCell", for: indexPath) as! AuthorDetailCollectionViewCell
        guard let image = UIImage(named: work[indexPath.row].image) else { return UICollectionViewCell()}
        cell.configure(image: image)
        return cell
    }
}

extension AuthorDetailCollectionViewController: UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(AuthorDetailCollectionViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension AuthorDetailCollectionViewController {
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
