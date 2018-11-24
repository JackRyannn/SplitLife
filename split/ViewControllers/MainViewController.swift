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
    var array = ["找到一份喜爱的工作","找到女朋友","养猫"]
    
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
        let subVC = sb.instantiateViewController(withIdentifier: "subViewController")

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
        
    }


}

