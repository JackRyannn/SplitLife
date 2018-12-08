//
//  AddViewController.swift
//  split
//
//  Created by RenChao on 2018/12/1.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    let stateArray:Array = ["待完成","已完成","完成失败"]
    let typeArray:Array = ["无类型","职业生涯","学习生涯","社交网络","艺术追求","身体素质"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("renchao===%s",stateArray.count)
        return stateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return stateArray[row]
    }
    //调整选择框尺寸
    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 50;
//    }
//
//    //设置行高
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 100;
//    }
    
    //检测响应选项的选择状态
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component,row);
        eventStateText.text = stateArray[row]
    }
   

    var sqlManager = SQLiteManager();
    @IBAction func CancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveBtnClicked(_ sender: Any) {
        sqlManager.insert(tableName: "t_event", dicFields: ["E_name":eventNameText.text!,"E_state":0])
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var eventNameText: UITextField!
    @IBOutlet weak var eventContentText: UITextField!
    @IBOutlet weak var eventStateText: UITextField!
    @IBOutlet weak var eventFinishTimeText: UITextField!
    

   

    @IBAction func eventStateAction(_ sender: Any) {
        print("eventState")
        let statePicker = UIPickerView(frame:CGRect(x:0,y:self.view.frame.size.height/3*2,width:self.view.frame.size.width, height:self.view.frame.size.height/3));
        statePicker.dataSource = self
        statePicker.delegate = self
        statePicker.showsSelectionIndicator = true;
        statePicker.selectRow(0,inComponent:0,animated:true)
        self.view.addSubview(statePicker)
        print("renchao===")
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
