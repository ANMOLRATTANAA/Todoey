//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Anmol Rattan on 18/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    var categories:Results<Category>?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let controller = UIAlertController(title: "Add Category Items", message: "", preferredStyle: .alert)
        let action =  UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            
        }
        controller.addTextField { (categoryTextField) in
            categoryTextField.placeholder = "Create Category"
            textField = categoryTextField
        }
        controller.addAction(action)
        present(controller,animated: true,completion: nil)
        
    }
    //MARK: - tableView DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    //MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "doItemCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? ""
        return cell
    }
    func save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("error while saving \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
       categories = realm.objects(Category.self)
        
      
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]  
        }
    }
}
