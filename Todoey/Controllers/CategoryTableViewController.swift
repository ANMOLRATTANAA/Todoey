//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Anmol Rattan on 18/06/18.
//  Copyright © 2018 Anmol Rattan. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
var categoryArray = [Category]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let controller = UIAlertController(title: "Add Category Items", message: "", preferredStyle: .alert)
        let action =  UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context : self.context)
            newCategory.name = textField.text
            self.categoryArray.append(newCategory)
            self.saveItems()
            
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
        return categoryArray.count
    }
    
    //MARK: - TableView Delegate Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "doItemCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    func saveItems(){
        do{
            try context.save()
            
        }catch{
            print("error while saving \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
          categoryArray =  try  context.fetch(request)
        }catch {
            print("error while fetchin data \(error)")
        }
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}
