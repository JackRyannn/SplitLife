//
//  AddAchievementViewController.swift
//  split
//
//  Created by RenChao on 2018/12/2.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class AddAchievementViewController: UIViewController {

    var sqlManager = SQLiteManager();
    var event_id:Int = 0
    var event_name:String = ""
    
    @IBOutlet weak var nameText: UITextField!
    
    //    取消button
    @IBAction func backBtnClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "系统提示",
                                                message: "未保存就退出吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "是的", style: .default, handler: {
            action in
            print("已退出")
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    //    保存button
    @IBAction func saveBtnClicked(_ sender: Any) {
        sqlManager.insert(tableName: "t_achievement", dicFields: ["a_name":nameText.text!,"a_state":0])
        let cur_achievement_id = sqlManager.getTableCount(tableName: "t_achievement")
        sqlManager.insert(tableName: "t_relationship", dicFields: ["r_pre_id":event_id,"r_next_id":cur_achievement_id,"r_next_name":nameText.text!,"r_type":2])
        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            let subVC:SubViewController = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
            subVC.event_id = self.event_id;
            subVC.event_name = self.event_name;
            self.present(subVC, animated: true, completion: nil)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
