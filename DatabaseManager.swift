//
//  DatabaseManager.swift
//  ClimateKitchenApp
//
//  Created by Wyatt Chrisman on 11/25/24.
//

import SQLite3
import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: OpaquePointer?

    private let dbPath = Bundle.main.path(forResource: "ClimateKitchen", ofType: "db") ?? ""
    
    private init() {
        connectToDatabase()
    }

    // Connect to the database
    private func connectToDatabase() {
        
        
        print("Connecting to database at: \(dbPath)")

        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Error opening database")
        } else {
            print("Successfully connected to database")
        }

    }

    // Save or update user data
    func saveUserData(uid: String, name: String, location: String, allergies: [String]) {
        let insertOrUpdateQuery = """
        INSERT INTO UserInfo (fb_id, name, location, none, vegetarian, vegan, peanuts, tree_nuts, gluten, dairy, eggs, shellfish, fish, soy)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(fb_id)
        DO UPDATE SET
            name = excluded.name,
            location = excluded.location,
            none = excluded.none,
            vegetarian = excluded.vegetarian,
            vegan = excluded.vegan,
            peanuts = excluded.peanuts,
            tree_nuts = excluded.tree_nuts,
            gluten = excluded.gluten,
            dairy = excluded.dairy, 
            eggs = excluded.eggs,
            shellfish = excluded.shellfish,
            fish = excluded.fish, 
            soy = excluded.soy;
        """

        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, insertOrUpdateQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (uid as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (location as NSString).utf8String, -1, nil)
            
            sqlite3_bind_int(statement, 4, allergies.isEmpty ? 1 : 0)  // `none` allergy
            sqlite3_bind_int(statement, 5, allergies.contains("Vegetarian") ? 1 : 0)
            sqlite3_bind_int(statement, 6, allergies.contains("Vegan") ? 1 : 0)
            sqlite3_bind_int(statement, 7, allergies.contains("Peanuts") ? 1 : 0)
            sqlite3_bind_int(statement, 8, allergies.contains("Tree Nuts") ? 1 : 0)
            sqlite3_bind_int(statement, 9, allergies.contains("Gluten") ? 1 : 0)
            sqlite3_bind_int(statement, 10, allergies.contains("Dairy") ? 1 : 0)
            sqlite3_bind_int(statement, 11, allergies.contains("Eggs") ? 1 : 0)
            sqlite3_bind_int(statement, 12, allergies.contains("Shellfish") ? 1 : 0)
            sqlite3_bind_int(statement, 13, allergies.contains("Fish") ? 1 : 0)
            sqlite3_bind_int(statement, 14, allergies.contains("Soy") ? 1 : 0)

            if sqlite3_step(statement) == SQLITE_DONE {
                print("User data saved or updated successfully.")
            } else {
                print("Could not save user data.")
            }
        } else {
            print("Save query preparation failed.")
        }
        sqlite3_finalize(statement)
    }

    // Load user data
    func loadUserData(uid: String) -> (name: String, location: String, allergies: [String])? {
        let query = "SELECT name, location, none, vegetarian, vegan, peanuts, tree_nuts, gluten, dairy, eggs, shellfish, fish, soy FROM UserInfo WHERE fb_id = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (uid as NSString).utf8String, -1, nil)

            if sqlite3_step(statement) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(statement, 0))
                let location = String(cString: sqlite3_column_text(statement, 1))


                var allergies: [String] = []
                if sqlite3_column_int(statement, 2) == 1 { allergies.append("None") }
                if sqlite3_column_int(statement, 3) == 1 { allergies.append("Vegetarian") }
                if sqlite3_column_int(statement, 4) == 1 { allergies.append("Vegan") }
                if sqlite3_column_int(statement, 5) == 1 { allergies.append("Peanuts") }
                if sqlite3_column_int(statement, 6) == 1 { allergies.append("Tree Nuts") }
                if sqlite3_column_int(statement, 7) == 1 { allergies.append("Gluten") }
                if sqlite3_column_int(statement, 8) == 1 { allergies.append("Dairy") }
                if sqlite3_column_int(statement, 9) == 1 { allergies.append("Eggs") }
                if sqlite3_column_int(statement, 10) == 1 { allergies.append("Shellfish") }
                if sqlite3_column_int(statement, 11) == 1 { allergies.append("Fish") }
                if sqlite3_column_int(statement, 12) == 1 { allergies.append("Soy") }
                

                sqlite3_finalize(statement)
                return (name, location, allergies)
            }
        } else {
            print("Query preparation failed.")
        }
        sqlite3_finalize(statement)
        return nil
    }
}
