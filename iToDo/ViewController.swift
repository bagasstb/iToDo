//
//  ViewController.swift
//  iToDo
//
//  Created by bagasstb on 27/03/19.
//  Copyright © 2019 xProject. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var listArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItem()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        let item = listArray[indexPath.row]
        
        cell.accessoryType = item.done ? .checkmark: .none
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteItem(index: indexPath.row)
        }
    }

    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add To Do List", message: "What will you do today?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.listArray.append(newItem)
            self.saveItem()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItem() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.listArray)
            try data.write(to: self.dataFilePath!)
            
        } catch {
            print("error")
        }
        self.tableView.reloadData()
    }
    
    func loadItem() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                listArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error \(error)")
            }
        }
    }
    
    func deleteItem(index: Int) {
        listArray.remove(at: index)
        saveItem()
    }
}

