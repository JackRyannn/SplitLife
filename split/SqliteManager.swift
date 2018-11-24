//
//  SqliteManager.swift
//  split
//
//  Created by RenChao on 2018/11/24.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import Foundation
import FMDB
class SQLiteManager: NSObject {
    static let sharedInstance: SQLiteManager = SQLiteManager()
    
    func dataBase() -> FMDatabase {
        var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        path = path + "/splitDB.sqlite"
        print(path)
        return FMDatabase.init(path: path)
    }
    
    func createTable(tableName: String) {
        let db = dataBase()
        if db.open() {
            let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('event_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'event_name' TEXT,'event_state' INTEGER );"
            if !db.executeStatements(sql_stmt) {
                print("Error: \(db.lastErrorMessage())")
            }
            db.close()
        } else {
            print("Error: \(db.lastErrorMessage())")
        }
        db.close()
    }
    
    
    func insert(tableName:String,dicFields:NSDictionary){
        let db = dataBase()
        if db.open() {
            let arFieldsKeys:[String] = dicFields.allKeys as! [String]
            let arFieldsValues:[Any] = dicFields.allValues
            var sqlUpdatefirst = "INSERT INTO '" + tableName + "' ("
            var sqlUpdateLast = " VALUES("
            for i in 0..<arFieldsKeys.count {
                if i != arFieldsKeys.count-1 {
                    sqlUpdatefirst = sqlUpdatefirst + arFieldsKeys[i] + ","
                    sqlUpdateLast = sqlUpdateLast + "?,"
                }else{
                    sqlUpdatefirst = sqlUpdatefirst + arFieldsKeys[i] + ")"
                    sqlUpdateLast = sqlUpdateLast + "?)"
                }
            }
            do{
                try db.executeUpdate(sqlUpdatefirst + sqlUpdateLast, values: arFieldsValues)
                print("数据库操作==== 添加数据成功！")
            }catch{
                print(db.lastErrorMessage())
            }
            
        }
    }
    

}

