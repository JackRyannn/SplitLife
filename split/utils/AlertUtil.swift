//
//  AlertUtil.swift
//  split
//
//  Created by JackRyannn on 2019/1/6.
//  Copyright © 2019 JackRyannn. All rights reserved.
//

import Foundation
import UIKit
class AlertUtil{
    
    //弹出消息
    class func showMessage(viewController:UIViewController,message:String){
        let alertController = UIAlertController(title: message,
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        viewController.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            print("提示框回调事件")
            viewController.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    
        
    
}
