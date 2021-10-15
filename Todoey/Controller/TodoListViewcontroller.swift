//
//  ViewController.swift
//  Todoey
//
//  Created by Jelena Tasic on 13.10.21..
//

import UIKit
// UITableViewController conforms To UITableViewDataSource, we dont have to write tableView.datasource = self...

class TodoListViewcontroller: UITableViewController {
    
    var itemArray = [Item]()
    
    //for local data storage, saves data in plist file
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "Test1"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Test2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Test3"
        itemArray.append(newItem3)
        
        //loads data from loacal data
        //        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
        //            itemArray = items
        //        }
    }
    
    //MARK:- Add New Item
    @IBAction func AddbuttonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray,forKey: "ToDoListArray")
            // relod tableView to see added new item
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
    //MARK:- TableView Delegate  Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // forces tableview reload data
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

