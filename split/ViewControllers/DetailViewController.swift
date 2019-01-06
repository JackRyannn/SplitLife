//
//  DetailViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/22.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var kv_items = ["名称":"五字以内","描述":"具体要求","状态":0,"类型":0,"计划开始时间":"2018-10-08","预计完成时间":"2018-10-08","键":"键名","值":"值","操作方法":1,"优先级":0,"删除":0] as [String : Any]
    let state_items = ["待完成","已完成","无法完成"]
    let type_items = ["无类型","职业生涯","学习生涯","社交网络","艺术追求","身体素质"]
    let operation_items = [">","<","="]
    
    var sqlManager = SQLiteManager();
    // flag = 0 element | 1 achievement
    var flag = 0;
    var parent_id:String = ""
    var head_id:String = ""
    var head_name:String = ""
    var element_id:String = ""
    var model_id:String = ""
    var table_name:String = ""
    
    @IBOutlet weak var detailTableView: UITableView!
    
    ////    取消button
    //    @IBAction func backBtnClicked(_ sender: Any) {
    //
    //        let alertController = UIAlertController(title: "系统提示",
    //                                                message: "未保存就退出吗？", preferredStyle: .alert)
    //        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    //        let okAction = UIAlertAction(title: "是的", style: .default, handler: {
    //            action in
    //            print("已退出")
    //            self.dismiss(animated: true, completion: nil)
    //        })
    //        alertController.addAction(cancelAction)
    //        alertController.addAction(okAction)
    //        self.present(alertController, animated: true, completion: nil)
    //
    //    }
    ////    保存button
    //    @IBAction func saveBtnClicked(_ sender: Any) {
    ////        if(flag==0){
    ////            sqlManager.insert(tableName: "t_element", dicFields: ["e_name":nameText.text!,"e_state":0])
    ////        }else{
    ////            sqlManager.insert(tableName: "t_achievement", dicFields: ["a_name":nameText.text!,"a_state":0])
    ////        }
    //
    //        let alertController = UIAlertController(title: "保存成功!",
    //                                                message: nil, preferredStyle: .alert)
    //        //显示提示框
    //        self.present(alertController, animated: true, completion: nil)
    //        //两秒钟后自动消失
    //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
    //            self.presentedViewController?.dismiss(animated: false, completion: nil)
    //            self.dismiss(animated: true, completion: nil)
    //        }
    //
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        如果为新建的element，那么少显示一个 是否删除
        if(element_id.isEmpty){
            return kv_items.count-1
        }
        return kv_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            print("ViewController:cell is nil")
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let keyLabel = cell?.viewWithTag(1) as? UILabel
        let valueLabel = cell?.viewWithTag(2) as? UILabel
        valueLabel?.textAlignment = NSTextAlignment.right
        switch indexPath.row {
        case 0:
            keyLabel?.text = "名称"
            valueLabel?.text = kv_items["名称"] as? String
            break
        case 1:
            keyLabel?.text = "描述"
            valueLabel?.text = "查看"
            break
        case 2:
            keyLabel?.text = "状态"
            valueLabel?.text = state_items[(kv_items["状态"] as? Int)!]
            break
        case 3:
            keyLabel?.text = "类型"
            valueLabel?.text = type_items[(kv_items["类型"] as? Int)!]
            break
        case 4:
            keyLabel?.text = "计划开始时间"
            valueLabel?.text = kv_items["计划开始时间"] as? String
            break
        case 5:
            keyLabel?.text = "预计完成时间"
            valueLabel?.text = kv_items["预计完成时间"] as? String
            break
        case 6:
            keyLabel?.text = "键"
            valueLabel?.text = kv_items["键"] as? String
            break
        case 7:
            keyLabel?.text = "值"
            valueLabel?.text = kv_items["值"] as? String
            break
        case 8:
            keyLabel?.text = "操作方法"
            valueLabel?.text = operation_items[(kv_items["操作方法"] as? Int)!]
            break
        case 9:
            keyLabel?.text = "优先级"
            valueLabel?.text = String(kv_items["优先级"] as! Int)
            break
        case 10:
            keyLabel?.text = "是否删除"
            valueLabel?.text = kv_items["删除"] as? String
            break
            
            
        default:
            print("Wrong at AddEventViewController")
        }
        return cell!
        
    }
    //    跳转到ValuesTableViewController界面,这里把self传过去，可以回调修改该VC的属性
    func jumpToValuesVTC(title:String,valueItems:[String],selected_id:Int=0){
        let sb = UIStoryboard(name: "Sub", bundle: nil)
        let valuesTVC = sb.instantiateViewController(withIdentifier: "valuesTableViewController") as! ValuesTableViewController
        valuesTVC.parentView2 = self
        valuesTVC.cur_title = title
        valuesTVC.value_items = valueItems
        valuesTVC.selected_id = selected_id
        self.present(valuesTVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let textVC = sb.instantiateViewController(withIdentifier: "textViewController") as! TextViewController
            textVC.parentView2 = self
            textVC.cur_title = "名称"
            textVC.cur_text = (kv_items["名称"] as! String)
            self.present(textVC, animated: true, completion: nil)
            break
        case 1:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let longTextVC = sb.instantiateViewController(withIdentifier: "longTextViewController") as! LongTextViewController
            longTextVC.parentView2 = self
            longTextVC.cur_title = "描述"
            longTextVC.cur_content = (kv_items["描述"] as! String)
            self.present(longTextVC, animated: true, completion: nil)
            break
        case 2:
            jumpToValuesVTC(title:"状态",valueItems: state_items,selected_id: kv_items["状态"] as! Int)
            break
        case 3:
            jumpToValuesVTC(title:"类型",valueItems:type_items,selected_id: kv_items["类型"] as! Int)
            break
        case 4:
            print("plan finish time")
            let datePicker = UIDatePicker(frame:CGRect(x:0,y:self.view.frame.size.height/3*2,width:self.view.frame.size.width, height:self.view.frame.size.height/3));
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(dateChanged),
                                 for: .valueChanged)
            let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 35)))
            let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dateChanged))
            
            toolBar.items = [spaceItem, doneItem]
            self.view.addSubview(datePicker)
            break
        case 5:
            print("real finish time")
            let datePicker = UIDatePicker(frame:CGRect(x:0,y:self.view.frame.size.height/3*2,width:self.view.frame.size.width, height:self.view.frame.size.height/3));
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(dateChanged),
                                 for: .valueChanged)
            let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 35)))
            let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            
            let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dateChanged))
            
            toolBar.items = [spaceItem, doneItem]
            self.view.addSubview(datePicker)
            break
        case 6:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let textVC = sb.instantiateViewController(withIdentifier: "textViewController") as! TextViewController
            textVC.parentView2 = self
            textVC.cur_title = "键"
            textVC.cur_text = (kv_items["键"] as! String)
            self.present(textVC, animated: true, completion: nil)
            break
        case 7:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let textVC = sb.instantiateViewController(withIdentifier: "textViewController") as! TextViewController
            textVC.parentView2 = self
            textVC.cur_title = "值"
            textVC.cur_text = (kv_items["值"] as! String)
            self.present(textVC, animated: true, completion: nil)
            break
        case 8:
            jumpToValuesVTC(title:"操作方法",valueItems: operation_items,selected_id: kv_items["操作方法"] as! Int)
            break
        case 10:
            let alertController = UIAlertController(title: "删除数据", message: "删除数据将不可恢复",
                                                    preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "删除", style: .destructive, handler: nil)
            //        let archiveAction = UIAlertAction(title: "保存", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            //        alertController.addAction(archiveAction)
            self.present(alertController, animated: true, completion: nil)
        default:
            print("Wrong at DetailViewController")
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        print("update date")
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        kv_items["计划开始时间"] = formatter.string(from: datePicker.date)
        
        detailTableView.reloadData()
    }
    
    
    
    
    
    @IBAction func CancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveBtnClicked(_ sender: Any) {
        let params = ["e_name":kv_items["名称"]!,"e_content":kv_items["描述"]!,"e_role_id":0,"e_state":kv_items["状态"]!,"e_type":kv_items["类型"]!,"e_plan_time":kv_items["计划开始时间"]!,"e_estimated_time":kv_items["预计完成时间"]!,"e_key":kv_items["键"]!,"e_value":kv_items["值"]!,"e_operator":kv_items["操作方法"]!,"e_priority":kv_items["优先级"]!,"e_enable":kv_items["删除"]!,"e_parent":parent_id,"e_child":""] as NSDictionary
        
        let cur_element_id = sqlManager.getTableCount(tableName: table_name)
        if(element_id == ""){
            //            新添加element 这里要用sql事务，暂未处理
            sqlManager.insert(tableName: table_name, dicFields: params)
            //            更新父节点的孩子
            print(sqlManager.select(tableName: table_name, arFieldsKey: ["e_child"], condition: "e_id='"+parent_id+"'"))
            let p_child = (sqlManager.select(tableName: table_name, arFieldsKey: ["e_child"], condition: "e_id='"+parent_id+"'")[0].object(forKey: "e_child") as! String)+String(cur_element_id)+","
            if(!sqlManager.update(tableName: table_name, dicFields: ["e_child":p_child], condition: "e_id='"+parent_id+"'")){
                print("更新父节点孩子失败")
            }else{
                print("更新父节点孩子成功")
            }
        }else{
            let ret = sqlManager.update(tableName: table_name, dicFields: params, condition:"e_id='"+element_id+"'" )
            print("更新状态\(ret)")
        }
        
        //        //sqlManager.insert(tableName: "t_relationship", dicFields: ["r_pre_id":pre_id,"r_next_id":cur_element_id,"r_next_name":kv_items["名称"]!,"r_type":r_type])
        //        }else{
        ////            保存原有element
        //            let ret = sqlManager.update(tableName: table_name, dicFields: params, condition:"e_id='"+element_id+"'" )
        ////            let ret2 = sqlManager.update(tableName: "t_relationship", dicFields: ["r_next_name":kv_items["名称"]!], condition:"r_next_id='"+element_id+"'" )
        ////            print("更新状态\(ret) \(ret2)")
        //        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("显示已存在的element")
        table_name = sqlManager.getTableName(modelId: model_id)
        let rs = sqlManager.select(tableName: table_name, arFieldsKey: ["e_id","e_name","e_content","e_state","e_type","e_plan_time","e_estimated_time","e_key","e_value","e_operator","e_priority","e_enable"],condition:"e_id='"+element_id+"'")
        if(rs.count<=0){
            print("数据库获取失败");
            return
        }
        print(rs)
        kv_items["名称"] = rs[0].object(forKey:"e_name")
        kv_items["描述"] = rs[0].object(forKey:"e_content")
        kv_items["状态"] = (rs[0].object(forKey:"e_state")as! NSString).integerValue
        kv_items["类型"] = (rs[0].object(forKey:"e_type")as! NSString).integerValue
        kv_items["计划开始时间"] = rs[0].object(forKey:"e_plan_time")
        kv_items["预计完成时间"] = rs[0].object(forKey:"e_estimated_time")
        kv_items["键"] = rs[0].object(forKey:"e_key")
        kv_items["值"] = rs[0].object(forKey:"e_value")
        kv_items["操作方法"] = (rs[0].object(forKey:"e_operator")as! NSString).integerValue
        kv_items["优先级"] = (rs[0].object(forKey:"e_priority")as! NSString).integerValue
        kv_items["删除"] = (rs[0].object(forKey:"e_enable")as! NSString).integerValue
        detailTableView.reloadData()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
}
