//
//  DatabaseHelper.swift
//  aynelgul-pset4
//
//  Created by Aynel Gül on 22-11-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    private let list = Table("list")
    private let id = Expression<Int64>("id")
    private let toDoPoint = Expression<String?>("toDoPoint")
//    private let check = Expression<Bool>("check")
    
    private var database: Connection?
    
    init?() {
        do {
           try setupDatabase()
        } catch {
            print(error)
            return nil
        }
    }
    
    private func setupDatabase() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            database = try Connection("\(path)/db.sqlite3")
            createTable()
        } catch {
            // error handling
            print ("Cannot connect to database: \(error)")
        }
    }
    
    private func createTable() {
        do {
            try database!.run(list.create(ifNotExists: true) { t in // CREATE TABLE "list"
                t.column(id, primaryKey: .autoincrement)            // "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                t.column(toDoPoint, unique: true)                   // "toDoPoint" TEXT UNIQUE NOT NULL
            } )
        } catch {
            // error handling
            print("Failed to create table: \(error)")
        }
    }
    
    func create(toDoPoint: String) throws {
        let insert = list.insert(self.toDoPoint <- toDoPoint)
        
        do {
            let rowId = try database!.run(insert)
            print(rowId)
        } catch {
            // Error handling.
            throw error
        }
    }
    
    func readAll() throws -> [String?] {
        
        var results = [String?]()
        
        do {
            for point in try database!.prepare(list.select(toDoPoint)) {
                results.append(point[toDoPoint])
            }
        } catch {
            throw error
        }
        print (results)
        return results
    }

    func deleteFromDatabase(name: String) throws {
    
        var deletePoint = list.filter(toDoPoint == name)
        let delete = deletePoint.delete()
        
        try print(database!.run(delete))

        
    }
}
