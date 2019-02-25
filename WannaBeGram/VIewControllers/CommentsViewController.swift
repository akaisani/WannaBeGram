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
    
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var commentsTableView: UITableView!
    var post: Post!
    var shouldShowBar = false
    let commentBar = MessageInputBar()
    var comments = [Comment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        
        // Do any additional setup after loading the view.
        
        CommentService.getCommentsForPost(post) { (comments) in
            guard let comments = comments else {return}
            self.comments = comments
            self.commentsTableView.reloadData()
        }
        
        
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
}


extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
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
        shouldShowBar = false
        inputBar.inputTextView.resignFirstResponder()
        
        guard inputBar.inputTextView.text.count > 0 else {return}
        
        CommentService.makeComment(inputBar.inputTextView.text, for: post) { (comment) in
            guard let comment = comment else {return}
            self.comments.append(comment)
            let indexPaths = [IndexPath(row: self.comments.count - 1, section: 1)]
            self.commentsTableView.insertRows(at: indexPaths, with: .fade)
        }

    }
    
    
    
}


