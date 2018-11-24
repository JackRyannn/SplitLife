//
//  DetailViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/22.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
//    取消button
    @IBAction func backBtnClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "系统提示",
                                                message: "未保存就退出吗？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "是的", style: .default, handler: {
            action in
            print("已退出")
            self.present(alertController, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)

    }
//    保存button
    @IBAction func saveBtnClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var str:String = "";
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
