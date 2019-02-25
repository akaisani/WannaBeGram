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
    var activityIndicator: UIActivityIndicatorView!
    var selectedPost: Post?
    
    @IBOutlet weak var postsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startSpinner()

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
            if self.activityIndicator.isAnimating {self.stopSpinner()}
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

    
    
    // MARK: - UIActivityIndicator Setup
    func startSpinner() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .purple
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopSpinner() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {return}
        if identifier == "toCommentsView" {
            guard let commentsVC = segue.destination as? CommentsViewController, let selectedPost = selectedPost else {return}
            commentsVC.post = selectedPost
        }
    }
    

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postHeaderCell", for: indexPath) as! PostHeaderCell
            cell.usernameLabel.text = post.poster.username
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postContentCell", for: indexPath) as! PostContentCell
            cell.postImageView.image = post.image
            cell.captionLabel.text = post.caption
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postActionCell", for: indexPath) as! PostActionCell
            //TODO: add code for like button
            //TODO: add code for date and like count
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "postCommentsCell", for: indexPath) as! PostCommentsCell
            let buttonTitle = post.commentsCount > 0 ? "View all \(post.commentsCount) comments" : "Add a comment..."
            let textRange = NSMakeRange(0, buttonTitle.count)
            let attributedText = NSMutableAttributedString(string: buttonTitle)
            attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "System Font Regular", size: 16.0)!, range: textRange)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: textRange)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            cell.viewCommentsButton.titleLabel?.attributedText = attributedText
            cell.commentViewAction = { [unowned self] in
                self.selectedPost = post
                self.performSegue(withIdentifier: "toCommentsView", sender: self)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch indexPath.row {
            case 1:
                return 427
            default:
                return 64
            }
        }

    
}
