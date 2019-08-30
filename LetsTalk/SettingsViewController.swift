//
//  SettingsViewController.swift
//  LetsTalk
//
//  Created by Aaron on 2019-08-29.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // this makes the "apple style" title in the setting viwe
        navigationController?.navigationBar.prefersLargeTitles = true

    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

   
    
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        FUser.logOutCurrentUser { (success) in
    
            if success {
                //show login view
                self.showLoginView()
                
            }
        }
    }
    
    func showLoginView() {
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
        
        self.present(mainView, animated: true, completion: nil)
    }
    
}
