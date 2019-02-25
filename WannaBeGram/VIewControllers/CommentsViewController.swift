//
//  CommentsViewController.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/22/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit
import MessageInputBar

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var currentUserProfileImageView: CircleImageView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentsTableView: UITableView!
    var post: Post!
    var shouldShowBar = false
    let commentBar = MessageInputBar()
    var comments = [Comment]()
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        // Do any additional setup after loading the view.
        startSpinner()
        CommentService.getCommentsForPost(post) { (comments) in
            guard let comments = comments else {return}
            self.comments = comments
            if self.comments.isEmpty {
                AlertControllerHelper.presentAlert(for: self, withTitle: "Hey!", withMessage: "Looks like this post has no comments, be the first one to comment!")
            }
            
            self.stopSpinner()
            self.commentsTableView.reloadData()
        }
        
        
    }
    
    
    func setupViews() {
        let url  = URL(string: User.current.profileImageURL)!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data)
        self.currentUserProfileImageView.image = image
        self.currentUserProfileImageView.layer.borderColor = UIColor.purple.cgColor

        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
    }
    
    func configureTableView() {
        // remove separators for empty cells
        commentsTableView.tableFooterView = UIView()
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @objc func keyboardWillShow(notification: Notification) {
        self.commentBar.inputTextView.text = ""
        self.commentBar.inputTextView.becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override func becomeFirstResponder() -> Bool {
        return shouldShowBar
    }
}


extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        let comment = comments[indexPath.row]
        cell.usernameLabel.text = comment.username
        cell.profileImageView.image = comment.userProfileImage
        cell.profileImageView.layer.borderColor = UIColor.purple.cgColor
        cell.profileImageView.backgroundColor = .black
        cell.commentLabel.text = comment.text
        return cell
    }
}

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
}

extension CommentsViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        self.shouldShowBar = false
        
        inputBar.inputTextView.resignFirstResponder()
        guard inputBar.inputTextView.text.count > 0 else {

            return
            
        }
        
        CommentService.makeComment(inputBar.inputTextView.text, for: post) {[unowned self] (comment) in
            guard let comment = comment else {return}
            DispatchQueue.main.async {
                
                self.comments.append(comment)
                inputBar.resignFirstResponder()
                self.commentsTableView.reloadData()
            }
        }
        
    }
    
    
    
}


