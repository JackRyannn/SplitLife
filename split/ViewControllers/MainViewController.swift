//
//  ViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/14.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    let sqlManager = SQLiteManager()
    var showMenu: Bool = false
    var path: NSIndexPath = NSIndexPath(row: 0, section: 0)
    
    @IBOutlet weak var lifeTableView: UITableView!
    
    var lifeArray = Array<NSMutableDictionary>()
    
    @IBAction func addElementClicked(_ sender: Any) {
        //        jumpToAddElementVC()
        print("添加新元素")
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.parent_id = "0"
        detailVC.head_id = "0"
        detailVC.head_name = "根节点"
        detailVC.element_id = ""
//        现在默认传1，因为还没有开发别的模版
        detailVC.model_id = "1"
        self.present(detailVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? TableViewCell
//         var cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if cell == nil{
            print("ViewController:cell is nil")
            cell = TableViewCell.init(style: TableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = lifeArray[indexPath.row].object(forKey: "element_name") as? String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        showMenu = true
        path = indexPath as NSIndexPath
        
        //cell中需要重写canBecomeFirstResponder
        let cell: TableViewCell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        cell.contentView.backgroundColor = UIColor.black
        
        //需要成为第一响应者
        cell.becomeFirstResponder()
        
        let menu: UIMenuController = UIMenuController.shared
        
        //这里的frame影响箭头的位置
        var rect: CGRect = cell.frame
        
        rect.size.width = 200
        
        menu.setTargetRect(rect, in: tableView)
        
        let item: UIMenuItem = UIMenuItem(title: "删除", action: #selector(MainViewController.delMenuPress(menu:)))
        let copyItem: UIMenuItem = UIMenuItem(title: "拷贝", action: #selector(MainViewController.delMenuPress(menu:)))
        
        menu.menuItems = [item,copyItem]
        
        menu.setMenuVisible(true, animated: true)
        
        return true
    }
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return false
    }
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            
            print("copy")
        }
    }
    @objc func delMenuPress(menu: UIMenuController) {
        
        print("删除成功")
        
        self.lifeTableView.reloadData()
    }
    @objc func reloadCell() {
        
        let cell: TableViewCell = lifeTableView.cellForRow(at: path as IndexPath) as! TableViewCell
        
        cell.contentView.backgroundColor = UIColor.white
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let subVC = SubViewController()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
        subVC.parent_id = "0"
        //        现在默认传1，因为还没有开发别的模版
        subVC.model_id = "1"
        subVC.head_id = (lifeArray[indexPath.row].object(forKey: "element_id") as? String)!
        subVC.cur_id = (lifeArray[indexPath.row].object(forKey: "element_id") as? String)!
        subVC.head_name = (lifeArray[indexPath.row].object(forKey: "element_name") as? String)!
        self.present(subVC, animated: true, completion: nil)
    }
    
    
    
    
    func queryAndUpdate(){
        lifeArray = Array<NSMutableDictionary>()
        let rs = sqlManager.select(tableName: "t_element_base", arFieldsKey: ["e_id","e_name"],condition:"e_parent='0'")
        for s in rs{
            let item = NSMutableDictionary()
            item.setObject(s.object(forKey: "e_id")! as! String, forKey: "element_id" as NSCopying)
            item.setObject(s.object(forKey: "e_name")! as! String, forKey: "element_name" as NSCopying)
            lifeArray.append(item)
        }
        self.lifeTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("===========MainViewController Init===========")
//        重写cell必须在这里注册一下identifier
        lifeTableView.register(UINib(nibName:"TableViewCell", bundle:nil), forCellReuseIdentifier:"tableViewCell")
        // Do any additional setup after loading the view, typically from a nib.
        let userDefault = UserDefaults.standard
        if(userDefault.value(forKey: "db_init") as? Bool != true){
            print("数据库初始化")
            sqlManager.createTableModel()
            sqlManager.createTableColumn()
            sqlManager.initTableModel()
            sqlManager.createTableElement(modelId: 0)
            
            userDefault.set(true,forKey:"db_init")
        }
        queryAndUpdate();
        //        sqlManager.insert(tableName: "t_event", dicFields: ["event_id":2,"event_name":"Travel around the world","event_state":0])
    }
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
    
    
}

