//
//  UserTableViewCell.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-29.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var fullNameLabel: UILabel!
    
    var indexPath: IndexPath!
    
    let tapGestureRecognizer = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tapGestureRecognizer.addTarget(self, action: #selector(self.avatarTap))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func genenrateCellWith(fUser: FUser, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.fullNameLabel.text = fUser.fullname
        // convert string to image
        
        if fUser.avatar != "" {
            imageFromData(pictureData: fUser.avatar) { (avatarImage) in
                if avatarImage != nil {
                    self.avatarImageView.image = avatarImage!.circleMasked
                }
            }
        }
        
    }
    
    @objc func avatarTap() {
        print("avatar tapped")
    }

}
