//
//  AddViewController.swift
//  split
//
//  Created by RenChao on 2018/12/1.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    var sqlManager = SQLiteManager();
    @IBAction func CancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveBtnClicked(_ sender: Any) {
        sqlManager.insert(tableName: "t_event", dicFields: ["E_name":eventNameText.text!,"E_state":0])
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var eventNameText: UITextField!
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
