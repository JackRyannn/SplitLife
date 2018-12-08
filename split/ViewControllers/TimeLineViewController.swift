//
//  TimeLineViewController.swift
//  split
//
//  Created by RenChao on 2018/12/5.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    var items = ["1","2","3","4","55"]
    
    @IBOutlet weak var timeLineTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TimeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "timeTableViewCell") as! TimeTableViewCell
        //        cell?.textLabel?.numberOfLines = 0       // 根据内容显示高度
        cell.timeLabel.text = items[indexPath.row]
        print(self.items)
        
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineTableView.register(UINib(nibName:"TimeTableViewCell", bundle:nil), forCellReuseIdentifier:"timeTableViewCell")

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

}
