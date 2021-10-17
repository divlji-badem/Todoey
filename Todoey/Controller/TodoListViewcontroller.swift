//
//  ViewController.swift
//  Todoey
//
//  Created by Jelena Tasic on 13.10.21..
//

import UIKit
import CoreData
// UITableViewController conforms To UITableViewDataSource, we dont have to write tableView.datasource = self...
class TodoListViewcontroller: UITableViewController {
    
    var itemArray = [Item]()
    var selectedCategory: Category? {
        didSet{
            //loadItems()
        }
    }
    // path where data is stored
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // insted of calling app delegate we call shared singleton app instance
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataFilePath)
        //loadItems()
    }
    
    //MARK:- TableView Datasource Methods
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        // Configure the cell’s contents.
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    //MARK:- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //updating value by setting the value for titile
        //itemArray[indexPath.row].setValue("Competed", forKey: "title")
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // deleting item on click, the order is important
        // deleting from context
//        context.delete(itemArray[indexPath.row])
//        // removig from itemArray
//        itemArray.remove(at: indexPath.row)

        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
//
//            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    //MARK:- Model Manipulation Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        // relod tableView to see added new item
        tableView.reloadData()
    }
    //parameter with default value
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let safePredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, safePredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fatching data from context \(error)")
//        }
//        tableView.reloadData()
//    }
}

//MARK:- UISearchBarDelegate
//extension TodoListViewcontroller: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // query database
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        //[cd] not case sensitive
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate)
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//            // it should happen in main tread
//            DispatchQueue.main.async {
//                // remove cursor from searchbar
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}

