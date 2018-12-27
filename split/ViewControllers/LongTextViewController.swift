//
//  LongTextViewController.swift
//  split
//
//  Created by JackRyannn on 2018/12/8.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class LongTextViewController: UIViewController {
    var parentView : AddEventViewController? = nil
    var parentView2 : DetailViewController? = nil
    var cur_title = ""
    var cur_content = ""
    @IBOutlet weak var longTextField: UITextView!
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtnClicked(_ sender: Any) {
        parentView?.kv_items[cur_title] = longTextField.text
        parentView?.addEventTableView.reloadData()
        parentView2?.kv_items[cur_title] = longTextField.text
        parentView2?.detailTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        longTextField.text = cur_content
        

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
