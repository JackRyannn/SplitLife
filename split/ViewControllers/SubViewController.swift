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
    var array_in = Array<String>()
    var array_out = Array<String>()
    var array = Array<String>()
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addNewInBtnClicked(_ sender: Any) {
        let addElementVC:AddElementViewController = sb.instantiateViewController(withIdentifier: "addElementViewController") as! AddElementViewController
        addElementVC.event_id = self.event_id;
        addElementVC.event_name = self.event_name;
        self.present(addElementVC, animated: true, completion: nil)
    }
    @IBAction func addNewOutBtnClicked(_ sender: Any) {
        let addAchievementVC:AddAchievementViewController = sb.instantiateViewController(withIdentifier: "addAchievementViewController") as! AddAchievementViewController
        addAchievementVC.event_id = self.event_id;
        addAchievementVC.event_name = self.event_name;
        self.present(addAchievementVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        queryAndUpdate()
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
                label?.text = array_in[indexPath.row]
            }
        }else if indexPath.section==1{
            if indexPath.row<array_out.count{
                label?.text = array_out[indexPath.row]
            }
        }
        return mainCell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.event_id = self.event_id;
        detailVC.event_name = self.event_name;
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
    
    func queryAndUpdate(){
        array_in = Array<String>()
        array_out = Array<String>()
        let rs = sqlManager.select(tableName: "t_relationship", arFieldsKey: ["r_pre_id","r_next_id","r_next_name","r_state","r_type","r_enable"])
        for s in rs{
            if(s.object(forKey: "r_state")! as! String == "0" && s.object(forKey: "r_enable")! as! String == "0" && s.object(forKey: "r_pre_id")! as! String == String.init(event_id)){
                if (s.object(forKey:"r_type")! as! NSString).intValue == 1{
                    array_in.append(s.object(forKey: "r_next_name")! as! String)
                }else if (s.object(forKey:"r_type")! as! NSString).intValue  == 2{
                    array_out.append(s.object(forKey: "r_next_name")! as! String)
                }
            }
        }
        print(array_in)
        print(array_out)
        self.subTableView.reloadData()
    }
    
    
    
}
