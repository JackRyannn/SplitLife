//
//  RCTextViewController.swift
//  split
//
//  Created by JackRyannn on 2018/12/8.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class RCTextViewController: UIViewController {
    var parentView : AddEventViewController? = nil
    var parentView2 : DetailViewController? = nil
    var cur_title = ""
    var cur_text = ""
    @IBOutlet weak var textField: UITextField!
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtnClicked(_ sender: Any) {
        parentView?.kv_items[cur_title] = textField.text
        parentView?.addEventTableView.reloadData()
        parentView2?.kv_items[cur_title] = textField.text
        parentView2?.detailTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = cur_text
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
