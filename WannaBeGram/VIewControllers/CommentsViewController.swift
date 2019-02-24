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
    var shouldShowBar = false
    let commentBar = MessageInputBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        
        // Do any additional setup after loading the view.
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        
        self.commentField.text = inputBar.inputTextView.text
        shouldShowBar = false
        inputBar.inputTextView.resignFirstResponder()
    }
    
    
    
}


