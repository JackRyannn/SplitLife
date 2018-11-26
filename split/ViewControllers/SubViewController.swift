//
//  MainViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/16.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit


class SubViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
    var event_id:Int = 0
    var event_name:String = ""
    var array_in = ["赚钱/per month>8000","定居成功"]
    var array_out = ["安全感+10","幸福感+20","疲劳感+5"]
    var array = Array<String>()
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SubViewController init")
        let manager = SQLiteManager()
        let rs = manager.select(tableName: "t_relationship", arFieldsKey: ["r_pre_id","r_next_id","r_next_name","r_state","r_enable"])
        for s in rs{
            if(s.object(forKey: "r_state")! as! String == "0" && s.object(forKey: "r_enable")! as! String == "0" && s.object(forKey: "r_pre_id")! as! String == String.init(event_id)){
            array_in.append(s.object(forKey: "r_next_name")! as! String)
            }
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
        print("enter load")
        print(indexPath.row)
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
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: "detailViewController")
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
   
    
}
