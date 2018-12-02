//
//  TodoViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/18.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var todoArray = Array<String>()
    let sqlManager = SQLiteManager()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = todoArray[indexPath.row]
        return cell!
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryAndUpdate()
    }
    
    func queryAndUpdate() {
        var rs = sqlManager.select(tableName: "t_element", arFieldsKey: ["e_id","e_name","e_state","e_difficulty"])
        print("====")
//  NSTaggedPointerString这种格式需要转换成NSString，然后取intValue
        rs.sort(by: {(obj1, obj2) -> Bool in return ((obj1.object(forKey: "e_difficulty") as! NSString).intValue) < (obj2.object(forKey: "e_difficulty")as! NSString).intValue })
        for s in rs{
            todoArray.append(s.object(forKey: "e_name")! as! String)
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

}
