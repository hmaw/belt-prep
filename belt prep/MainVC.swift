//
//  MainVC.swift
//  belt prep
//
//  Created by Heather Wilcox on 9/24/18.
//  Copyright © 2018 Heather Wilcox. All rights reserved.
//

import UIKit
import CoreData

protocol CanTakeItemInfo {
    func takeItemInfo(_ item: Item)
}

class MainVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext  //allowing us to access staging area in the appdelegate
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var tableData: [Item] = []

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "homeToNewSegue", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        
        if segue.identifier == "homeToInfoSegue" {
            print("Hey")
            let dest = nav.topViewController as! DisplayInfo
            if let indexPath = sender as? IndexPath {
                let data = tableData[indexPath.row]
                dest.titleStr = data.title!
                dest.noteStr = data.note!
                dest.dateStr = data.date!
                dest.indexPath = indexPath
                print(dest.titleStr)
            }
            
        } else if segue.identifier == "homeToNewSegue" {
            let dest = nav.topViewController as! addEditVC
            dest.delegate = self
            if let indexPath = sender as? IndexPath {
                let data = tableData[indexPath.row]
                dest.titleStr = data.title!
                dest.noteStr = data.note!
                dest.dateStr = data.date!
                dest.indexPath = indexPath
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableData = fetchData()
    }
    func fetchData() -> [Item] {
        var items: [Item] = [] //Creating an empty array to store fetched items
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()  //fetches the items from persistant Container/Objects
        do {
            items = try context.fetch(fetchRequest) //
        } catch  {
            print("Failed to fetch data in do-catch")
        }
        return items
        
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! myCell
        cell.labelField.text = tableData[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "homeToInfoSegue", sender: indexPath)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, done in
            let item = self.tableData[indexPath.row]
            self.context.delete(item)
            self.saveContext()
            self.tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            done(true)
            
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") {
            action, view, done in
            self.performSegue(withIdentifier: "homeToNewSegue", sender: indexPath)
        }
        edit.backgroundColor = .blue
        
        let actions:[UIContextualAction] = [delete, edit]
        return UISwipeActionsConfiguration(actions: actions)
    }
}
extension MainVC: AddEditVCDelegate{
    func addEditItem(_ title: String, _ note: String, _ date: Date, _ indexPath: IndexPath?) {
        let item: Item
        if let indexPath = indexPath {  
            item = tableData[indexPath.row]
            print("Editing Item")
        } else {
            item = Item(context: context)
            tableData.append(item)
        }
        
        item.title = title
        item.note = note
        item.date = date
        saveContext()
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
    }
    
}

