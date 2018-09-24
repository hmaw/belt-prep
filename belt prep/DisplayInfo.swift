//
//  DisplayInfo.swift
//  belt prep
//
//  Created by Heather Wilcox on 9/24/18.
//  Copyright © 2018 Heather Wilcox. All rights reserved.
//

import UIKit
import CoreData

class DisplayInfo: UIViewController {
    var titleStr: String = ""
    var noteStr: String = ""
    var dateStr: Date = Date()
    var indexPath: IndexPath?
    
    @IBOutlet weak var titleField: UILabel!
    
    @IBOutlet weak var dateField: UILabel!
    
    @IBOutlet weak var noteField: UITextView!
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        noteField.text = noteStr
        titleField.text = titleStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.string(from: dateStr)
        dateField.text = date
        
    }

}

