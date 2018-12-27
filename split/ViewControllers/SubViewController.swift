//
//  MainViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/16.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit


class SubViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
//    这个是用来暂存点击的element的id的
    var cur_element_id : String = ""
    let sqlManager = SQLiteManager()
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    @IBOutlet weak var subTableView: UITableView!
    //    0的话什么都不做，1来自element，2，来自achievement
//    var jump_from:Int = 0
    var event_id:String = ""
    var event_name:String = ""
    var cur_id:String = ""
    var array_in = Array<NSMutableDictionary>()
    var array_out = Array<NSMutableDictionary>()
    var array = Array<NSDictionary>()
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addNewInBtnClicked(_ sender: Any) {
//        jumpToAddElementVC()
        print("添加新元素")
        let element_id = cur_element_id
        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.event_id = self.event_id
        detailVC.event_name = self.event_name
        detailVC.pre_id = cur_id;
        detailVC.element_id = element_id
        self.present(detailVC, animated: true, completion: nil)
    }
    @IBAction func addNewOutBtnClicked(_ sender: Any) {
        jumpToAddAchievementVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func jumpToAddElementVC(index:Int){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
        subVC.event_id = event_id;
        subVC.cur_id = array_in[index].value(forKey:"element_id") as! String
        subVC.event_name = array_in[index].value(forKey:"element_name") as! String
        self.present(subVC, animated: true, completion: nil)
    }
    func jumpToAddAchievementVC(achievement_id:String = "0"){
        let addAchievementVC:AddAchievementViewController = sb.instantiateViewController(withIdentifier: "addAchievementViewController") as! AddAchievementViewController
        addAchievementVC.event_id = self.event_id
        addAchievementVC.event_name = self.event_name
        addAchievementVC.achievement_id = achievement_id
        self.present(addAchievementVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "输入条件"
        }else{
            return "输出条件"
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return array_in.count
        }else if section == 1{
            return array_out.count
        }
        return 0;
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell")
        if mainCell == nil{
            print("cell is nil")
            mainCell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "MainCell")
        }
        let label = mainCell?.viewWithTag(1) as? UILabel
        if indexPath.section==0{
            if indexPath.row < array_in.count{
                label?.text = array_in[indexPath.row].object(forKey: "element_name") as? String
            }
        }else if indexPath.section==1{
            if indexPath.row<array_out.count{
                label?.text = array_out[indexPath.row].object(forKey: "achievement_name") as? String
            }
        }
        let detailBtn = mainCell?.viewWithTag(2) as? UIButton
//        设置子事件的修改属性btn   selector里面的方法要传参数需要传可点击控件，所以通过传递tag来实现传递数据
        detailBtn?.addTarget(self, action: #selector(detailBtnClicked(_:)), for: UIControl.Event.touchUpInside)
        print("renchao")
        print(array_in)
        print(indexPath.row)
        cur_element_id = array_in[indexPath.row].object(forKey: "element_id") as! String
        return mainCell!
    }
    
    @objc func detailBtnClicked(_ sender:UIButton){

        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.event_id = self.event_id
        detailVC.event_name = self.event_name
        detailVC.element_id = cur_element_id
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            jumpToAddElementVC(index: indexPath.row)
        }else if indexPath.section == 1{
            jumpToAddAchievementVC(achievement_id: array_out[indexPath.row].object(forKey: "achievement_id") as! String)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
/***
     更新列表
     逻辑：查看relationship，前置id和当前id一致，则判断后置id是元素还是成果，分别添加到对应的array里
 ***/
    func queryAndUpdate(){
        array_in = Array<NSMutableDictionary>()
        array_out = Array<NSMutableDictionary>()
        var r_type = 0
        if(event_id == cur_id){
            r_type = 1
        }else{
            r_type = 2
        }
        let rs = sqlManager.select(tableName: "t_relationship", arFieldsKey: ["r_pre_id","r_next_id","r_next_name","r_state","r_type","r_enable"],condition:"r_type=\(r_type)")
        for s in rs{
            if(s.object(forKey: "r_state")! as! String == "0" && s.object(forKey: "r_enable")! as! String == "0" && s.object(forKey: "r_pre_id")! as! String == String.init(cur_id)){
                if (s.object(forKey:"r_type")! as! NSString).intValue == 1{
                    let item = NSMutableDictionary()
                    item.setObject(s.object(forKey: "r_next_id")! as! String, forKey: "element_id" as NSCopying)
                    item.setObject(s.object(forKey: "r_next_name")! as! String, forKey: "element_name" as NSCopying)
                    array_in.append(item)
                }else if (s.object(forKey:"r_type")! as! NSString).intValue  == 2{
                    let item = NSMutableDictionary()
                    item.setObject(s.object(forKey: "r_next_id")! as! String, forKey: "achievement_id" as NSCopying)
                    item.setObject(s.object(forKey: "r_next_name")! as! String, forKey: "achievement_name" as NSCopying)
                    array_out.append(item)
                }
            }
        }
        self.subTableView.reloadData()
    }
    
    
    
}
