//
//  AddViewController.swift
//  split
//
//  Created by RenChao on 2018/12/1.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var kv_items = ["名称":"五字以内","描述":"具体要求","状态":0,"类型":0,"完成时间":"2018-10-08"] as [String : Any]
    let state_items = ["待完成","已完成","无法完成"]
    let type_items = ["无类型","职业生涯","学习生涯","社交网络","艺术追求","身体素质"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kv_items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            print("ViewController:cell is nil")
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let keyLabel = cell?.viewWithTag(1) as? UILabel
        let valueLabel = cell?.viewWithTag(2) as? UILabel
        valueLabel?.textAlignment = NSTextAlignment.right
        switch indexPath.row {
        case 0:
            keyLabel?.text = "名称"
            valueLabel?.text = kv_items["名称"] as? String
            break
        case 1:
            keyLabel?.text = "描述"
            valueLabel?.text = "查看"
            break
        case 2:
            keyLabel?.text = "状态"
            valueLabel?.text = state_items[(kv_items["状态"] as? Int)!]
            break
        case 3:
            keyLabel?.text = "类型"
            valueLabel?.text = type_items[(kv_items["类型"] as? Int)!]
            break
        case 4:
            keyLabel?.text = "完成时间"
            valueLabel?.text = kv_items["完成时间"] as? String
            break
       
        default:
            print("Wrong at AddEventViewController")
        }
        return cell!
        
    }
//    跳转到ValuesTableViewController界面,这里把self传过去，可以回调修改该VC的属性
    func jumpToValuesVTC(title:String,valueItems:[String],selected_id:Int=0){
        let sb = UIStoryboard(name: "Sub", bundle: nil)
        let valuesTVC = sb.instantiateViewController(withIdentifier: "valuesTableViewController") as! ValuesTableViewController
        valuesTVC.parentView = self
        valuesTVC.cur_title = title
        valuesTVC.value_items = valueItems
        valuesTVC.selected_id = selected_id
        self.present(valuesTVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let textVC = sb.instantiateViewController(withIdentifier: "textViewController") as! TextViewController
            textVC.parentView = self
            textVC.cur_title = "名称"
            textVC.cur_text = (kv_items["名称"] as! String)
            self.present(textVC, animated: true, completion: nil)
           break
        case 1:
            let sb = UIStoryboard(name: "Sub", bundle: nil)
            let longTextVC = sb.instantiateViewController(withIdentifier: "longTextViewController") as! LongTextViewController
            longTextVC.parentView = self
            longTextVC.cur_title = "描述"
            longTextVC.cur_content = (kv_items["描述"] as! String)
            self.present(longTextVC, animated: true, completion: nil)
            break
        case 2:
            jumpToValuesVTC(title:"状态",valueItems: state_items,selected_id: kv_items["状态"] as! Int)
            break
        case 3:
            jumpToValuesVTC(title:"类型",valueItems:type_items,selected_id: kv_items["类型"] as! Int)
            break
        case 4:
           let datePicker = UIDatePicker(frame:CGRect(x:0,y:self.view.frame.size.height/3*2,width:self.view.frame.size.width, height:self.view.frame.size.height/3));
           datePicker.datePickerMode = .date
           datePicker.addTarget(self, action: #selector(dateChanged),
                                for: .valueChanged)
           let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 0, height: 35)))
           let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           
           let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(dateChanged))
           
           toolBar.items = [spaceItem, doneItem]
           self.view.addSubview(datePicker)
            break
        default:
            print("Wrong at AddEventViewController")
        }
    }
    
    @IBOutlet weak var addEventTableView: UITableView!
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        print("update date")
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd"
        kv_items["完成时间"] = formatter.string(from: datePicker.date)
        
        addEventTableView.reloadData()
    }
    

   

    var sqlManager = SQLiteManager();
    @IBAction func CancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SaveBtnClicked(_ sender: Any) {
        sqlManager.insert(tableName: "t_event", dicFields: ["E_name":kv_items["名称"]!,"E_content":kv_items["描述"]!,"E_state":kv_items["状态"]!,"E_type":kv_items["类型"]!])
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
