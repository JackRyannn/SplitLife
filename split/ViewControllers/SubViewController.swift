//
//  MainViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/16.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit


class SubViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let sqlManager = SQLiteManager()
    let sb = UIStoryboard.init(name: "Main", bundle: nil)
    @IBOutlet weak var subTableView: UITableView!
    //    0的话什么都不做，1来自element，2，来自achievement
//    var jump_from:Int = 0
    var event_id:Int = 0
    var event_name:String = ""
    var array_in = Array<NSMutableDictionary>()
    var array_out = Array<NSMutableDictionary>()
    var array = Array<NSDictionary>()
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addNewInBtnClicked(_ sender: Any) {
        jumpToAddElementVC()
    }
    @IBAction func addNewOutBtnClicked(_ sender: Any) {
        jumpToAddAchievementVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        queryAndUpdate()
    }

    func jumpToAddElementVC(element_id:String = "0"){
        let addElementVC:AddElementViewController = sb.instantiateViewController(withIdentifier: "addElementViewController") as! AddElementViewController
        addElementVC.event_id = self.event_id
        addElementVC.event_name = self.event_name
        addElementVC.element_id = element_id
        self.present(addElementVC, animated: true, completion: nil)
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
        return mainCell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            jumpToAddElementVC(element_id: array_in[indexPath.row].object(forKey: "element_id") as! String)
        }else if indexPath.section == 1{
            jumpToAddAchievementVC(achievement_id: array_out[indexPath.row].object(forKey: "achievement_id") as! String)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
    
    func queryAndUpdate(){
        array_in = Array<NSMutableDictionary>()
        array_out = Array<NSMutableDictionary>()
        let rs = sqlManager.select(tableName: "t_relationship", arFieldsKey: ["r_pre_id","r_next_id","r_next_name","r_state","r_type","r_enable"])
        for s in rs{
            if(s.object(forKey: "r_state")! as! String == "0" && s.object(forKey: "r_enable")! as! String == "0" && s.object(forKey: "r_pre_id")! as! String == String.init(event_id)){
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
