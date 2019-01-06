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
   func createTableModel() {
      let tableName = "t_model"
      let db = dataBase()
      if db.open() {
//         遗留：未加上unique
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('m_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'m_name' TEXT,'m_tablename' TEXT,'m_state' INTEGER NOT NULL DEFAULT 0,'m_type' INTEGER DEFAULT 0,'m_create_time' DATETIME,'m_update_time' DATETIME,'m_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   func initTableModel(){
      insert(tableName: "t_model", dicFields: ["m_name":"base_model","m_tablename":"t_element_base","m_state":0,"m_type":0,"m_create_time":"2018-12-27","m_update_time":"2018-12-27","m_enable":0])

      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_id","c_alias":"元素id","c_attr":"INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_name","c_alias":"描述","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_content","c_alias":"内容","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_role_id","c_alias":"角色id","c_attr":"INTEGER NOT NULL","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_state","c_alias":"状态","c_attr":"INTEGER NOT NULL","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_type","c_alias":"类型","c_attr":"INTEGER NOT NULL","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_create_time","c_alias":"创建时间","c_attr":"DATETIME","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_plan_time","c_alias":"计划开始时间","c_attr":"DATETIME","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_estimated_time","c_alias":"预计完成时间","c_attr":"DATETIME","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_finish_time","c_alias":"实际完成时间","c_attr":"DATETIME","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_key","c_alias":"键","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_value","c_alias":"值","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_operator","c_alias":"操作方法","c_attr":"INTEGER","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_priority","c_alias":"优先级","c_attr":"INTEGER NOT NULL","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_enable","c_alias":"是否删除","c_attr":"INTEGER NOT NULL","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_parent","c_alias":"父节点","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
      insert(tableName: "t_column", dicFields: ["c_model_id":0,"c_name":"e_child","c_alias":"子节点","c_attr":"TEXT","c_state":0,"c_type":0,"c_enable":0])
   }
   
   //    创建表
   func createTableElement(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('e_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'e_name' TEXT,'e_content' TEXT,'e_role_id' INTEGER NOT NULL DEFAULT 0,'e_state' INTEGER DEFAULT 0, 'e_type' INTEGER DEFAULT 0,'e_create_time' DATETIME,'e_plan_time' DATETIME,'e_estimated_time' DATETIME,'e_finish_time' DATETIME,'e_key' TEXT,'e_value' TEXT,'e_operator' INTEGER,'e_priority' INTEGER DEFAULT 0,'e_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   
   //    创建表t_column
   func createTableColumn() {
      let tableName = "t_column"
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('c_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'c_model_id' INTEGER NOT NULL,'c_name' TEXT,'c_alias' TEXT,'c_attr' TEXT,'c_state' INTEGER DEFAULT 0, 'c_type' INTEGER DEFAULT 0,'c_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
   
   //    创建表t_relationship
   func createTableRelationship(tableName: String) {
      let db = dataBase()
      if db.open() {
         let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ('r_id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'r_pre_id' INTEGER,'r_next_id' INTEGER,'r_next_name' TEXT,'r_role_id' INTEGER NOT NULL DEFAULT 0,'r_state' INTEGER DEFAULT 0, 'r_type' INTEGER DEFAULT 0,'r_enable' INTEGER DEFAULT 0);"
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
   }
//   根据modelId创建表
   func createTableElement(modelId:Int){
      let ret_model = select(tableName: "t_model", arFieldsKey: ["m_name","m_tablename"],condition:"m_id=1")
      let tableName = ret_model[0].object(forKey: "m_tablename")! as! String
      let ret_cols = select(tableName: "t_column", arFieldsKey: ["c_name","c_attr"],condition:"c_model_id=\(modelId)")
      var params = ""
      for s in ret_cols{
         params += "'\(s.object(forKey: "c_name") ?? "")' \(s.object(forKey: "c_attr") ?? ""),"
      }
      params = String(params.prefix(params.count-1))
      let sql_stmt = "CREATE TABLE IF NOT EXISTS " + tableName + " ("+params+");"
      print(sql_stmt)
      print("==============================")
      let db = dataBase()
      if db.open() {
         
         if !db.executeStatements(sql_stmt) {
            print("Error: \(db.lastErrorMessage())")
         }
         db.close()
      } else {
         print("Error: \(db.lastErrorMessage())")
      }
      db.close()
//      插入模板的根结点
      insert(tableName: tableName, dicFields: ["e_id":0,"e_name":"根节点","e_content":"","e_role_id":0,"e_state":0,"e_type":0,"e_plan_time":"0000-00-00","e_create_time":"0000-00-00","e_estimated_time":"0000-00-00","e_finish_time":"0000-00-00","e_key":"","e_value":"","e_operator":0,"e_priority":0,"e_enable":0,"e_parent":"","e_child":""])
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
   
   //MARK: - 通过属性查询数据
   /// 查询数据
   ///
   /// - Parameters:
   ///   - tableName: 表名称
   ///   - arFieldsKey: 要查询获取的表字段
   /// - Returns: 返回相应数据
   func select(tableName:String,arFieldsKey:NSArray,condition:String)->([NSMutableDictionary]){
      let db = dataBase()
      var arFieldsValue = [NSMutableDictionary]()
      let sql = "SELECT * FROM " + tableName + " WHERE " + condition
      print(sql)
      if db.open() {
         do{
            let rs = try db.executeQuery(sql, values: nil)
            while rs.next() {
               let dicFieldsValue :NSMutableDictionary = [:]
               for i in 0..<arFieldsKey.count {
                  let temp = rs.string(forColumn: arFieldsKey[i] as! String)
//                  数据库取出的字段可能为空，所以这里为空就不添加到数组返回了，后面的？？是提供一个默认值
//                  if (!(temp?.isEmpty ?? true)){
//                     dicFieldsValue.setObject(rs.string(forColumn: arFieldsKey[i] as! String)!, forKey: arFieldsKey[i] as! NSCopying)
//                  }
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
   
   //MARK: - 更新数据
   /// 更新数据
   ///
   /// - Parameters:
   ///   - tableName: 表名称
   ///   - arFieldsKey: 要更新字段
   /// - Returns: 返回是否更新成功
   func update(tableName:String , dicFields:NSDictionary ,condition :String)->(Bool){
      var result:Bool = false
      let arFieldsKey : [String] = dicFields.allKeys as! [String]
      let arFieldsValues:[Any] = dicFields.allValues
      var sqlUpdate  = "UPDATE " + tableName +  " SET "
      for i in 0..<dicFields.count {
         if i != arFieldsKey.count - 1 {
            sqlUpdate = sqlUpdate + arFieldsKey[i] + " = ?,"
         }else {
            sqlUpdate = sqlUpdate + arFieldsKey[i] + " = ?"
         }
         
      }
      sqlUpdate = sqlUpdate + " WHERE " + condition
      let db = dataBase()
      if db.open() {
         do{
            try db.executeUpdate(sqlUpdate, values: arFieldsValues)
            print("数据库操作==== 修改数据成功！")
            result = true
         }catch{
            print(db.lastErrorMessage())
         }
      }
      return result
   }
   
//    插入表
    func insert(tableName:String,dicFields:NSDictionary){
        let db = dataBase()
        print("插入数据库：\(tableName)")
        print("数据：\(dicFields)")
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
                print("数据库插入 ==== 添加数据成功！")
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
   
   func getTableName(modelId:String)->(String){
      let db = dataBase()
      var tablename = ""
      let sql = "SELECT m_tablename FROM t_model WHERE m_id=" + modelId
      if db.open() {
         do{
            let rs = try db.executeQuery(sql, values: nil)
            while rs.next() {
               tablename = rs.string(forColumn: "m_tablename")!
            }
         }catch{
            print(db.lastErrorMessage())
         }
         
      }
      print("查询模版id得到表名为："+tablename)
      return tablename
   }
   
   /**
    
    **/
   
   
   
}

