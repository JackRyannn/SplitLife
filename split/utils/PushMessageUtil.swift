//
//  PushMessageUtil.swift
//  split
//
//  Created by JackRyannn on 2019/1/16.
//  Copyright © 2019 JackRyannn. All rights reserved.
//

import Foundation
import UserNotifications
class PushMessageUtil {
    
    static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    static func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
//    发送信息，但是只支持固定时间，不支持每日每月或者倒计时几天
    static func sendPushMessage(msgTitle:String,msgBody:String,datetime:Date) -> Bool {
        print("start send msg")
        let content = UNMutableNotificationContent()
        content.title = msgTitle
        content.body = msgBody
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        
        //        dateComponents.weekday = 3  // Tuesday
        dateComponents.year = datetime.year
        dateComponents.month = datetime.month
        dateComponents.day = datetime.day
        dateComponents.hour = datetime.hour    // 14:00 hours
        dateComponents.minute = datetime.minute
        
        //        Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
        //        先默认发送成功
        return true
    }
    
}
