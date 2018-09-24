//
//  myCell.swift
//  belt prep
//
//  Created by Heather Wilcox on 9/24/18.
//  Copyright © 2018 Heather Wilcox. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {
    @IBAction func bulletPressed(_ sender: UIButton) {
        if bulletLabel.currentTitle == "○" {
            bulletLabel.setTitle("●", for: .normal)
        } else {
            bulletLabel.setTitle("○", for: .normal)
        }
    }
    
    @IBOutlet weak var bulletLabel: UIButton!
    
    
    @IBOutlet weak var labelField: UILabel!
    
    

}
