//
//  ViewController.swift
//  Todoey
//
//  Created by Anmol Rattan on 14/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    var toDoItems: Results<Item>?
    var realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadItem()
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
     
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            //terenary Operator
            //value= condition ? valueiftrue : valueiffalse
            cell.accessoryType = (item.done) ?.checkmark : .none
            
        }else{
          cell.textLabel?.text = "No Items Added Yet"
        }
       return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = toDoItems?[indexPath.row]{
            do{
                try realm.write {
                    item.done = !item.done
                }
            }catch{
                print("error while changing done property \(error)")
            }
        }
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
//MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add the new ToDo in your list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.item.append(newItem)
                    }
                }catch{
                    print("error while adding items in list is \(error).self")
                }
                
            }
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder =  "Create New item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        self.present(alert,animated: true,completion: nil)
    
        
    }
    
   func loadItem(){
  toDoItems =   selectedCategory?.item.sorted(byKeyPath: "title", ascending: true)
    tableView.reloadData() 

    }
   
}
extension TodoListViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       loadItemWithPredicate(text: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{

            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }else{
            loadItemWithPredicate(text: searchBar.text!)
        }
    }
    func loadItemWithPredicate(text:String){
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()


    }


}
