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
    var parent_id:String = ""
    var model_id:String = ""
    var head_id:String = ""
    var head_name:String = ""
    var cur_id:String = ""
    var array_in = Array<NSMutableDictionary>()
    var array_out = Array<NSMutableDictionary>()
    var array = Array<NSDictionary>()
    var table_name:String = ""
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addNewInBtnClicked(_ sender: Any) {
//        jumpToAddElementVC()
        print("添加新元素")
//        let element_id = cur_element_id
        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        
        detailVC.model_id = self.model_id
        detailVC.head_id = self.head_id
        detailVC.head_name = self.head_name
        detailVC.parent_id = cur_id;
//        detailVC.element_id = element_id
        self.present(detailVC, animated: true, completion: nil)
    }
//    @IBAction func addNewOutBtnClicked(_ sender: Any) {
////        jumpToAddAchievementVC()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func jumpToAddElementVC(index:Int){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
        subVC.model_id = "1"
        subVC.head_id = head_id;
        subVC.cur_id = array_in[index].value(forKey:"element_id") as! String
        subVC.head_name = array_in[index].value(forKey:"element_name") as! String
        self.present(subVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        这个是根据e_type来分的，目前分为两类，如果=1，就是array_in,否则为array_2，待修改！！！！
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "子目标"
        }else{
            return "输出条件"
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return array_in.count
        }else if section == 1{
//            return array_out.count
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
//        设置子事件的查看修改btn   selector里面的方法要传参数需要传可点击控件，所以通过传递tag来实现传递数据
        detailBtn?.addTarget(self, action: #selector(detailBtnClicked(_:)), for: UIControl.Event.touchUpInside)
        print("renchao")
        print(array_in)
        print(indexPath.row)

        cur_element_id = array_in[indexPath.row].object(forKey: "element_id") as! String
        return mainCell!
    }
    
    @objc func detailBtnClicked(_ sender:UIButton){

        let detailVC:DetailViewController = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailVC.model_id = self.model_id
        detailVC.head_id = self.head_id
        detailVC.head_name = self.head_name
        detailVC.element_id = cur_element_id
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            jumpToAddElementVC(index: indexPath.row)
        }else if indexPath.section == 1{
//            jumpToAddAchievementVC(achievement_id: array_out[indexPath.row].object(forKey: "achievement_id") as! String)
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
        table_name = sqlManager.getTableName(modelId: model_id)
        array_in = Array<NSMutableDictionary>()
        array_out = Array<NSMutableDictionary>()
        var rs = sqlManager.select(tableName: table_name, arFieldsKey: ["e_child"], condition: "e_id='"+cur_id+"'")
        if(rs.count<=0){
            print("查询子节点为空")
            return
        }
        let arr_child = (rs[0].object(forKey: "e_child") as! String).split(separator: ",")
        for i in arr_child{
            let rs_child = sqlManager.select(tableName: table_name, arFieldsKey: ["e_name","e_type","e_enable"], condition: "e_id='"+i+"'")
            if(rs_child.count<=0){
                print("父节点对应的孩子查不到，按理说这是fatal，一般不会走到")
                return
            }

            let item = NSMutableDictionary()
            item.setObject(rs_child[0].object(forKey: "e_name")! as! String, forKey: "element_name" as NSCopying)
            item.setObject(i, forKey: "element_id" as NSCopying)
            item.setObject(rs_child[0].object(forKey: "e_enable")! as! NSString, forKey: "e_enable" as NSCopying)
            if((rs_child[0].object(forKey: "e_type")! as! NSString).intValue == 0 && (rs_child[0].object(forKey: "e_enable")! as! NSString).intValue == 0){
                array_in.append(item)
            }else{
                array_out.append(item)
            }
        }
        print("gggg")
        print(array_in)
        self.subTableView.reloadData()
    }
    
    
    
}
