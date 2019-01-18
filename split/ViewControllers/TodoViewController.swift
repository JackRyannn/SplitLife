//
//  TodoViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/18.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoArray = Array<NSMutableDictionary>()
    let sqlManager = SQLiteManager()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "todoTableViewCell") as? TodoTableViewCell
        if cell == nil{
            print("ViewController:cell is nil")
            cell = TodoTableViewCell.init(style: TodoTableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = todoArray[indexPath.row].object(forKey: "element_name") as? String
        let dayLeftLabel = cell?.viewWithTag(3) as? UILabel
        let cur_date = Date()
        if(!((todoArray[indexPath.row].object(forKey: "element_estimated_time") as? String)=="0000-00-00 00:00:00")){
            let elememt_date = PushMessageUtil.stringConvertDate(string: (todoArray[indexPath.row].object(forKey: "element_estimated_time") as? String)!)
            
            dayLeftLabel?.text = "剩余时间："+String(Calendar.current.dateComponents([.day], from: cur_date, to: elememt_date).day!)+"天"
        }
        
        let priorityLabel = cell?.viewWithTag(4) as? UILabel
        priorityLabel?.text = "优先级："+(todoArray[indexPath.row].object(forKey: "element_priority") as? String ?? "未知")
        return cell!
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        renchao=先自定义了行高
        todoTableView.rowHeight = 70
        todoTableView.register(UINib(nibName:"TodoTableViewCell", bundle:nil), forCellReuseIdentifier:"todoTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
    
    func queryAndUpdate() {
        var rs = sqlManager.select(tableName: "t_element_base", arFieldsKey: ["e_id","e_name","e_state","e_priority","e_plan_time","e_estimated_time"],condition:"e_id!='0' AND e_state==0")
        //  NSTaggedPointerString这种格式需要转换成NSString，然后取intValue
        //        xuan qu
        rs.sort(by: {(obj1, obj2) -> Bool in return ((obj1.object(forKey: "e_priority") as! NSString).intValue) > (obj2.object(forKey: "e_priority")as! NSString).intValue })
        rs.sort(by: {(obj1, obj2) -> Bool in return (obj1.object(forKey: "e_estimated_time") as! String) < (obj2.object(forKey: "e_estimated_time")as! String) })
        for s in rs{
            let item = NSMutableDictionary()
            item.setObject(s.object(forKey: "e_id")! as! String, forKey: "element_id" as NSCopying)
            item.setObject(s.object(forKey: "e_name")! as! String, forKey: "element_name" as NSCopying)
            item.setObject(s.object(forKey: "e_state")! as! String, forKey: "element_state" as NSCopying)
            item.setObject(s.object(forKey: "e_priority")! as! String, forKey: "element_priority" as NSCopying)
            item.setObject(s.object(forKey: "e_plan_time")! as! String, forKey: "element_plan_time" as NSCopying)
            item.setObject(s.object(forKey: "e_estimated_time")! as! String, forKey: "element_estimated_time" as NSCopying)
            
            todoArray.append(item)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
