//
//  MyViewController.swift
//  split
//
//  Created by JackRyannn on 2018/11/18.
//  Copyright © 2018 JackRyannn. All rights reserved.
//

import UIKit



class MyViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //类变量使用
    struct Constants{
        static var data:NSMutableDictionary = NSMutableDictionary()
        
    }
    
    
    //    设置每个section的标题
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (Constants.data.allKeys[section]) as? String
    }
    //    设置section的个数
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.data.count
    }
    //    设置每个section内cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Constants.data.allValues[section] as! NSArray).count
    }
    //    设置cell内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            print("cell is nil")
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(1) as? UILabel
        label?.text = (Constants.data.allValues[indexPath.section] as! NSArray).object(at:indexPath.row) as? String
        return cell!
    }
//    创建文件
    func createFile(name:String, baseUrl:NSURL){
        let manager = FileManager.default
        let fileUrlPath = baseUrl.appendingPathComponent(name)
        
        let exist = manager.fileExists(atPath: (fileUrlPath?.path)!)
        if !exist {
            manager.createFile(atPath:(fileUrlPath?.path)!, contents: nil, attributes: nil)
        }
    }

    
    
    //   点击事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((Constants.data.allValues[indexPath.section] as! NSArray).object(at: indexPath.row)) Clicked")
        if(indexPath.row == 2){

//
            let httpUtil = HttpUtil.shareManager()
            httpUtil.upload()
            
            
            
            
            
//            let params : NSMutableDictionary = [:]
//            let message : NSMutableDictionary = [:]
//            params.setValue("RC000001", forKey: "TransCode")
//            message.setValue("10001", forKey: "user_id")
//            message.setValue("this is ios information", forKey: "user_info")
//            params.setValue(message, forKey: "message")
//            let httpUtil = HttpUtil.shareManager()
//            httpUtil.requestData(.post, urlString: "http://localhost:1352/setUserInfo", parameters: params as? [String : AnyObject], success:{ (resp) in print(resp)}, failure: {(err) in print(err)})
        }
        if(indexPath.row == 3){
            let httpUtil = HttpUtil.shareManager()
//            这里是从博客里的静态文件里下载，可以查看linux我建立了一个软连接
            httpUtil.download(webURL: "http://renchao.site/static/upload/splitDB_1.sqlite", filename: "splitDB.sqlite")
            AlertUtil.showMessage(viewController: self,message: "更新完成")
//            let params : NSMutableDictionary = [:]
//            let message : NSMutableDictionary = [:]
//            params.setValue("RC000002", forKey: "TransCode")
//            message.setValue("10001", forKey: "user_id")
//            message.setValue("2018-12-15", forKey: "info_date")
//            params.setValue(message, forKey: "message")
//            let httpUtil = HttpUtil.shareManager()
//            httpUtil.requestData(.post, urlString: "http://localhost:1352/getUserInfo", parameters: params as? [String : AnyObject], success:{ (resp) in print(resp)}, failure: {(err) in print(err)})
        }
    }
    
    //页面加载
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.data = NSMutableDictionary.init(contentsOfFile: Bundle.main.path(forResource: "my", ofType: "plist")!)!
        
        
        
        
        
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
