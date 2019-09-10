//
//  ProfileViewTableViewController.swift
//  LetsTalk
//
//  Created by Aaron on 2019-09-09.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit

class ProfileViewTableViewController: UITableViewController {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var blockButton: UIButton!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var user:FUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // IBactions
    
    @IBAction func messageButtonPressed(_ sender: Any) {
        print("chat with user\(user!.fullname)")
    }
    
    @IBAction func blockUserButtonPressed(_ sender: Any) {
        var currentBlockedids = FUser.currentUser()!.blockedUsers
        if currentBlockedids.contains(user!.objectId) {
            let ind = currentBlockedids.firstIndex(of: user!.objectId)
            currentBlockedids.remove(at: ind!)
        } else {
             currentBlockedids.append(user!.objectId)
        }
        updateCurrentUserInFirestore(withValues: [kBLOCKEDUSERID: currentBlockedids]) { (err) in
            if err != nil {
                print("error updating user\(err!.localizedDescription)")
                return
            }
            self.updateBlockStatus()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    // to reomve the section ttiles we need the folowing 2 methods
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
   
    func setupUI() {
        if user != nil {
            self.title = "Profile"
            fullNameLabel.text = user?.fullname
            phoneNumberLabel.text = user?.phoneNumber
            
            updateBlockStatus()
            imageFromData(pictureData: user!.avatar) { (avatarImage) in
                if avatarImage != nil {
                    self.avatarImageView.image = avatarImage?.circleMasked
                }
            }
        }
    }
    
    func updateBlockStatus() {
        if user!.objectId != FUser.currentId() {
            blockButton.isHidden = false
            messageButton.isHidden = false
        } else {
            blockButton.isHidden = true
            messageButton.isHidden = true
        }
        
        if FUser.currentUser()!.blockedUsers.contains(user!.objectId) {
            blockButton.setTitle("Unblock User", for: .normal)
        } else {
            blockButton.setTitle("Block User", for: .normal)
        }
    }

}
