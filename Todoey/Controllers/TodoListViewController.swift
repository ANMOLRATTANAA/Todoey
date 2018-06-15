//
//  ViewController.swift
//  Todoey
//
//  Created by Anmol Rattan on 14/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item()
        newItem.titleOfItem = "jfskjjsa"
        itemArray.append(newItem)
        //if let item = defaults.array(forKey: "toDoItem")  as? [Item] {
           // itemArray = item
           
       // }
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.titleOfItem
      //terenary Operator
        //value= condition ? valueiftrue : valueiffalse
        cell.accessoryType = item.done ?.checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
//MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add the new ToDo in your list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            let newItem = Item()
            newItem.titleOfItem = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "toDoItem")
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

