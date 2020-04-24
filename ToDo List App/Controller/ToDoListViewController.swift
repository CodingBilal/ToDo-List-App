//
//  ViewController.swift
//  ToDo List App
//
//  Created by Bilal Hussain on 22/04/2020.
//  Copyright © 2020 Bilal Hussain. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Beat the Demigorgon", "Get some Cake"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "ToDoAppArray") {
            itemArray = items as! [String]
        }
        
    }

    
    //MARK: - Datasource and Number of cells in tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK: - Delegate Method for TableView when selecting a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)
        //print(itemArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)

        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }   else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    }
    
    //MARK: - Bar Button (Addition)
    
    @IBAction func barButtonAddition(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo", message: "", preferredStyle: .alert)
        
        let actionAlert = UIAlertAction(title: "OK", style: .default) { (actionSaidAlert) in
            //What will happen once user clicks OK on the alert
            print("Success")
            print(textField.text!)
            
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoAppArray")
            
            self.tableView.reloadData()
        }
       
       alert.addTextField { (alertTextField) in
        
        textField = alertTextField
        textField.placeholder = "Enter new ToDo"
        
        }
        
        alert.addAction(actionAlert)
        
        present(alert, animated: true, completion: nil)
    }
    
}

