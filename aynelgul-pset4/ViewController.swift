//
//  ViewController.swift
//  aynelgul-pset4
//
//  Created by Aynel Gül on 21-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var database = DatabaseHelper()
    
    var points: [String?] = []
    
    @IBAction func addButton(_ sender: UIButton) {
        // Put userInput in database.
        if userInput.text == "" {
            return
        }
        
        do {
            try database!.create(toDoPoint: userInput.text!)
            update()
        } catch {
            print(error)
        }
        
        userInput.text=""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        restorationIdentifier = "MyViewControllerRestorationId"
//        restorationClass = MyViewController.self
        
        if database == nil {
            print("Error")
        }
        
        update()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // grootte en inhoud bepalen TableView, volgende twee functies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoCell
        
        cell.toDoLabel?.text = points[indexPath.row]
    
        return cell
    }
    
    // swipe delete button (volgende twee functies)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                        
            // delete from SQLite database
            let name = points[indexPath.row]
            
            points.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)

            do {
                try database!.deleteFromDatabase(name: name!)
            } catch {
                print(error)
            }
        
        }
    }
    
    // functie inladen points met database
    func update() {
        do {
            points = try database!.readAll() as! [String]
        } catch let error as NSError {
            print(error.userInfo)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

