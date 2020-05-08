//
//  ViewController.swift
//  ToDo List App
//
//  Created by Bilal Hussain on 22/04/2020.
//  Copyright © 2020 Bilal Hussain. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [DataModel]()
    
    //let defaults = UserDefaults.standard
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(filePath!)
        
        
//        if let items = defaults.array(forKey: "ToDoAppArray") as? [DataModel] {
//            itemArray = items
//        }
        
//        let newItems = DataModel()
//        newItems.title = "Find Mike"
//        itemArray.append(newItems)
//
//        let newItemsTwo = DataModel()
//        newItemsTwo.title = "Buy Eggos"
//        itemArray.append(newItemsTwo)
//
//        let newItemsThree = DataModel()
//        newItemsThree.title = "Defeat Demigorgon"
//        itemArray.append(newItemsThree)
//
//        let newItemsFour = DataModel()
//        newItemsFour.title = "Rescue 11"
//        itemArray.append(newItemsFour)
        
        loadData()
        
    }

    
    //MARK: - Datasource and Number of cells in tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none
        
        //MARK: - The line above replaces the 4 lines of code below. The line above is a ternery operator line stating if the condition for the value which is the cells accessory type is true then it is a checkmark otherwise it is none.
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }   else {
//            cell.accessoryType = .none
//        }
        
        //print("cellForRowAt Method")
        
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

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //MARK: - The line above replaces the 4 lines of code below - the line above is for checking BOOL statements. BOOL statements can only be true / false.
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }   else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveData()
        
    }
    
    //MARK: - Bar Button (Addition)
    @IBAction func barButtonAddition(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo", message: "", preferredStyle: .alert)
        
        let actionAlert = UIAlertAction(title: "OK", style: .default) { (actionSaidAlert) in
            //What will happen once user clicks OK on the alert
            
            print("Success")
            print(textField.text!)
            
            let newItem = DataModel()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveData()
            
            //self.defaults.set(self.itemArray, forKey: "ToDoAppArray")
            //self.defaults.setValue(self.itemArray, forKey: "ToDoAppArray")
            
            //self.tableView.reloadData()
        }
       
       alert.addTextField { (alertTextField) in
        
        textField = alertTextField
        textField.placeholder = "Enter new ToDo"
        
        }
        
        alert.addAction(actionAlert)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        let encode = PropertyListEncoder()
        do {
            let dataEncoded = try encode.encode(itemArray)
            try dataEncoded.write(to: filePath!)
        }   catch {
            print("Error Encoding Items, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        do {
        if let decodeFilePathData = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder()
            itemArray = try decoder.decode([DataModel].self, from: decodeFilePathData)
            }
        }   catch {
            print("Error Decoding Items, \(error)")
        }
    }

}

