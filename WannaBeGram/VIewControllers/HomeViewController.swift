//
//  HomeViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/16/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    var posts = [Post]()
    let refreshControl = UIRefreshControl()

    
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        reloadTimeline()
    }
    
    
    @objc func reloadTimeline() {
        UserService.timeline { (posts) in
            self.posts = posts
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.postsTableView.reloadData()
        }
    }
    
    func configureTableView() {
        // remove separators for empty cells
        postsTableView.tableFooterView = UIView()
        
        // remove separators from cells
        postsTableView.separatorStyle = .none
        
        // add pull to refresh
        refreshControl.addTarget(self, action: #selector(reloadTimeline), for: .valueChanged)
        refreshControl.tintColor = UIColor.purple
        postsTableView.addSubview(refreshControl)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postHeaderCell", for: indexPath) as! PostHeaderCell
            cell.usernameLabel.text = post.poster.username
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postContentCell", for: indexPath) as! PostContentCell
            cell.postImageView.image = post.image
            cell.captionLabel.text = post.caption
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postActionCell", for: indexPath) as! PostActionCell
            //TODO: add code for like button
            //TODO: add code for date and like count
            return cell
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.section {
            case 0:
                return 64
            case 1:
                return 427
            case 2:
                return 64
                
            default:
                return 0
            }
        }

    
}
