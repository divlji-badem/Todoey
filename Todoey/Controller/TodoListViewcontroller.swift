//
//  ViewController.swift
//  Todoey
//
//  Created by Jelena Tasic on 13.10.21..
//

import UIKit
// UITableViewController conforms To UITableViewDataSource, we dont have to write tableView.datasource = self...

class TodoListViewcontroller: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Test 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Tableview Datasource Methods
    
    // Return the number of rows for the table.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
       
       // Configure the cell’s contents.
        cell.textLabel!.text = itemArray[indexPath.row]
           
       return cell
    }
}

