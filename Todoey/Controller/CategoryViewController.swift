//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jelena Tasic on 16.10.21..
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    //outo updating container that s why we dont need to append new category to categories
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.separatorStyle = .none
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].hexColor ?? "#5AC8FA")
        return cell
    }
    
    //MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.hexColor = UIColor.randomFlat().hexValue()
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    //MARK: - Data manipulation
    func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        } catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row]{
            do {
                try self.realm.write({
                    self.realm.delete(category)
                })
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }

    //MARK: - TableView delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    // this will triger just before we trigger performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewcontroller
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
}
