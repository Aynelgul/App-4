//
//  ViewController.swift
//  aynelgul-pset4
//
//  Created by Aynel Gül on 21-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    
    // MARK: SQLite database.
    var database: Connection?
    
    @IBAction func addButton(_ sender: UIButton) {
        // userinput invoeren in SQL/updaten
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // database aanmaken
        setupDatabase()
        
        // ophalen lijst SQL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // functie voor verwijderen punt
        // ook verwijderen uit SQL
    
    func setupDatabase() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/db.sqlite3")
        } catch {
            // error handling
            print ("Cannot connect to database: \(error)")
        }
    }


}
