//
//  ViewController.swift
//  Todoey
//
//  Created by Jelena Tasic on 13.10.21..
//

import UIKit
// UITableViewController conforms To UITableViewDataSource, we dont have to write tableView.datasource = self...

class TodoListViewcontroller: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Test 3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            if let safeString = textField.text {
                self.itemArray.append(safeString)
            }
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
       
       // Configure the cell’s contents.
        cell.textLabel?.text = itemArray[indexPath.row]
           
       return cell
    }
    //MARK:- TableView Delegate  Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // select and deselect row
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

