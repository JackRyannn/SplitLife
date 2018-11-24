//
//  MainViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/16.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit


class SubViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var array_in = ["赚钱/per month>8000","定居成功"]
    var array_out = ["安全感+10","幸福感+20","疲劳感+5"]
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainVC init")
        
        // Do any additional setup after loading the view.
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
        if section == 1{
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
            if indexPath.row<array_in.count{
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
