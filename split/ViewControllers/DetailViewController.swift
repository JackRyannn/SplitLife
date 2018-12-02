//
//  DetailViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/22.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var sqlManager = SQLiteManager();
    // flag = 0 element | 1 achievement
    var flag = 0;
    var event_id:Int = 0
    var event_name:String = ""
    var element_id:String = ""
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
//        if(flag==0){
//            sqlManager.insert(tableName: "t_element", dicFields: ["e_name":nameText.text!,"e_state":0])
//        }else{
//            sqlManager.insert(tableName: "t_achievement", dicFields: ["a_name":nameText.text!,"a_state":0])
//        }

        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
