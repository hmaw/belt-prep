//
//  addEditVC.swift
//  belt prep
//
//  Created by Heather Wilcox on 9/24/18.
//  Copyright © 2018 Heather Wilcox. All rights reserved.
//
protocol AddEditVCDelegate {
    func addEditItem(_ title: String, _ note: String, _ date: Date, _ indexPath: IndexPath?)
    
}
import UIKit

class addEditVC: UIViewController {
    var delegate: AddEditVCDelegate! //as a ! so that it forces it to crash per ELI

    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var noteField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    
    var titleStr: String = ""
    var noteStr: String = ""
    var dateStr = Date()
    var indexPath: IndexPath?
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated:true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dateField.date = dateStr
        noteField.text = noteStr
        titleField.text = titleStr
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        delegate?.addEditItem(titleField.text!, noteField.text!, dateField.date, indexPath)
    }
    
}

