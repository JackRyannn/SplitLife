//
//  AddElementViewController.swift
//  split
//
//  Created by RenChao on 2018/12/2.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class AddElementViewController: UIViewController {
    
    var sqlManager = SQLiteManager();
    var head_id:String = ""
    var head_name:String = ""
    var element_id = "0"
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
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
        sqlManager.insert(tableName: "t_element", dicFields: ["e_name":nameText.text!,"e_state":0])
        let cur_element_id = sqlManager.getTableCount(tableName: "t_element")
        sqlManager.insert(tableName: "t_relationship", dicFields: ["r_pre_id":head_id,"r_next_id":cur_element_id,"r_next_name":nameText.text!,"r_type":1])
        
        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            let subVC:SubViewController = sb.instantiateViewController(withIdentifier: "subViewController") as! SubViewController
            subVC.head_id = self.head_id;
            subVC.head_name = self.head_name;
            self.present(subVC, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("===========AddElement===========")
        print(element_id)
        let rs = sqlManager.select(tableName: "t_element", arFieldsKey: ["e_name","e_content","e_state","e_type","e_create_time","e_plan_time","e_estimated_time","e_finish_time","e_key","e_value","e_operator","e_difficulty","e_enable"],condition:"e_id='"+element_id+"'")
        if rs.count > 0{
            let navigationItem = navigationBar.topItem
            navigationItem?.title = rs[0].object(forKey: "e_name") as? String
        }
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
