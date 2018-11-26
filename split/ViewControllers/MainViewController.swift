//
//  ViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/14.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var lifeTableView: UITableView!
    @IBAction func AddEvent(_ sender: Any) {
        array.append("环游世界")
        lifeTableView.reloadData()
    }
    var array = Array<String>()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            print("ViewController:cell is nil")
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = array[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("VC:click")
//        let subVC = SubViewController()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
        subVC.event_id = indexPath.row
        subVC.event_name = array[indexPath.row]
        self.present(subVC, animated: true, completion: nil)
        print("VC:Done")
    }
    
    

    @IBOutlet var myText: [UILabel]!
    @IBOutlet var hh: [UITextField]!
    @IBOutlet weak var myBtn: UIButton!
    @IBAction func btn_touchdown(_ sender: Any) {
        
    }
    @IBAction func btn_click(_ sender: AnyObject){

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = SQLiteManager()
        manager.createTableEvent(tableName: "t_event")
        manager.createTableElement(tableName: "t_element")
        manager.createTableRelationship(tableName: "t_relationship")
        
//        manager.insert(tableName: "t_event", dicFields: ["event_id":2,"event_name":"Travel around the world","event_state":0])
        let rs = manager.select(tableName: "t_event", arFieldsKey: ["E_id","E_name"])
        for s in rs{
            array.append(s.object(forKey: "E_name")! as! String)
        }
    }


}

