//
//  ViewController.swift
//  Todoey
//
//  Created by Anmol Rattan on 14/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["IOS","Swift","CoreData","CoreML"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item =  defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = item
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
//MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add the new ToDo in your list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            let addItemText = textField.text
            self.itemArray.append(addItemText!)
            self.defaults.set(self.itemArray, forKey:"ToDoListArray")
           
            self.tableView.reloadData()
         
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder =  "Create New item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    
        
    }
}

