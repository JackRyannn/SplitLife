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
    
   //    创建表
   func createTableEvent(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('E_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'E_name' TEXT,'E_content' TEXT,'E_state' INTEGER DEFAULT 0, 'E_type' INTEGER DEFAULT 0,'E_create_time' DATETIME,'E_plan_time' DATETIME,'E_estimated_time' DATETIME,'E_finish_time' DATETIME,'E_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   
   //    创建表
   func createTableElement(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('e_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'e_name' TEXT,'e_content' TEXT,'e_state' INTEGER DEFAULT 0, 'e_type' INTEGER DEFAULT 0,'e_create_time' DATETIME,'e_plan_time' DATETIME,'e_estimated_time' DATETIME,'e_finish_time' DATETIME,'e_key' TEXT,'e_value' TEXT,'e_operator' INTEGER,'e_difficulty' INTEGER DEFAULT 0,'e_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   
   //    创建表t_achievement
   func createTableAchievement(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('a_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'a_name' TEXT,'a_content' TEXT,'a_state' INTEGER DEFAULT 0, 'a_type' INTEGER DEFAULT 0,'a_create_time' DATETIME,'a_plan_time' DATETIME,'a_estimated_time' DATETIME,'a_finish_time' DATETIME,'a_key' TEXT,'e_value' TEXT,'a_operator' INTEGER,'a_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   
   //    创建表
   func createTableRelationship(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('r_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'r_pre_id' INTEGER,'r_next_id' INTEGER,'r_next_name' TEXT,'r_state' INTEGER DEFAULT 0, 'r_type' INTEGER DEFAULT 0,'r_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
    //MARK: - 查询数据
    /// 查询数据
    ///
    /// - Parameters:
    ///   - tableName: 表名称
    ///   - arFieldsKey: 要查询获取的表字段
    /// - Returns: 返回相应数据
    func select(tableName:String,arFieldsKey:NSArray)->([NSMutableDictionary]){
        let db = dataBase()
        var arFieldsValue = [NSMutableDictionary]()
        let sql = "SELECT * FROM " + tableName
        if db.open() {
            do{
                let rs = try db.executeQuery(sql, values: nil)
                while rs.next() {
                  let dicFieldsValue :NSMutableDictionary = [:]
                  for i in 0..<arFieldsKey.count {
                        dicFieldsValue.setObject(rs.string(forColumn: arFieldsKey[i] as! String)!, forKey: arFieldsKey[i] as! NSCopying)
                    }
                    arFieldsValue.append(dicFieldsValue)
                }
            }catch{
                print(db.lastErrorMessage())
            }
            
        }
      print("查询数据结果：")
      print(arFieldsValue)
        return arFieldsValue
    }
    
//    插入表
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
                print("数据库操作 ==== 添加数据成功！")
            }catch{
                print(db.lastErrorMessage())
            }
            
        }
    }
    
    //MARK: - 删除数据
    /// 删除数据
    ///
    /// - Parameters:
    ///   - tableName: 表名称
    ///   - FieldKey: 过滤的表字段
    ///   - FieldValue: 过滤表字段对应的值
    func delete(tableName:String,FieldKey:String,FieldValue:Any) {
        let db = dataBase()
        
        if db.open() {
            let  sql = "DELETE FROM '" + tableName + "' WHERE " + FieldKey + " = ?"
            
            do{
                try db.executeUpdate(sql, values: [FieldValue])
                print("删除成功")
            }catch{
                print(db.lastErrorMessage())
            }
        }
        
    }
//    查看表长度
   func getTableCount(tableName:String)->(Int){
      let db = dataBase()
      var tableCount = Int()
      let sql = "SELECT COUNT(*) FROM " + tableName
      if db.open() {
         do{
            let rs = try db.executeQuery(sql, values: nil)
            while rs.next() {
               tableCount = Int(rs.int(forColumnIndex: 0))
            }
         }catch{
            print(db.lastErrorMessage())
         }
         
      }
      print("查询表+"+tableName+"内有："+String.init(tableCount)+"条数据")
      return tableCount
   }
}

