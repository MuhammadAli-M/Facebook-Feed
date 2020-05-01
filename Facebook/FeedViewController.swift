//
//  ViewController.swift
//  Facebook
//
//  Created by Muhammad Adam on 4/15/20.
//  Copyright © 2020 MAA. All rights reserved.
//

import UIKit

let cellId = "cellId"
class FeedViewController: UITableViewController {

    let posts = [
        Post(userName: "Mark Zukerberg",
             userImage: "mark_zuckerberg",
             postText: "By giving people the power to share, we're making the world more transparent.",
             postImageName: "zukerberg_dog"),
        Post(userName: "Muhammad Ali",
             userImage: "muhammad_ali",
             postText: "I hated every minute of training, but I said, 'Don't quit. Suffer now and live the rest of your life as a champion.'",
             postImageName: ""),
        Post(userName: "Albert Einstein",
        userImage: "albert_einstein",
        postText: "It's not that I'm so smart, it's just that I stay with problems longer.",
        postImageName: ""),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.backgroundColor = .gray
        tableView.alwaysBounceVertical = true
        tableView.register(FeedCell.self, forCellReuseIdentifier: cellId)
        navigationController?.navigationBar.barTintColor = UIColor(hex: 0x58729C)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Feed"
        tableView.estimatedRowHeight = 400.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        tableView.separatorColor = .lightGray
}

}


extension FeedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        super.tableView(tableView, numberOfRowsInSection: section)
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FeedCell

        cell.post = posts[indexPath.row]

        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.invalidateIntrinsicContentSize()
    }
}

