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

    @IBOutlet weak var lifeTableView: UITableView!

    var lifeArray = Array<String>()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lifeArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            print("ViewController:cell is nil")
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = lifeArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("VC:click")
//        let subVC = SubViewController()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
        subVC.event_id = indexPath.row
        subVC.event_name = lifeArray[indexPath.row]
        self.present(subVC, animated: true, completion: nil)
        print("VC:Done")
    }
    
    

    
    func queryAndUpdate(){
        lifeArray = Array<String>()
        let rs = sqlManager.select(tableName: "t_event", arFieldsKey: ["E_id","E_name"])
        for s in rs{
            lifeArray.append(s.object(forKey: "E_name")! as! String)
        }
        self.lifeTableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("===========MainViewController Init===========")
        // Do any additional setup after loading the view, typically from a nib.

        sqlManager.createTableEvent(tableName: "t_event")
        sqlManager.createTableElement(tableName: "t_element")
        sqlManager.createTableRelationship(tableName: "t_relationship")
        sqlManager.createTableAchievement(tableName: "t_achievement")
        queryAndUpdate();
//        sqlManager.insert(tableName: "t_event", dicFields: ["event_id":2,"event_name":"Travel around the world","event_state":0])
    }
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }


}

