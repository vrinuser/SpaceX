//
//  DateHelper.swift
//  SingleltonDemo
//
//  Created by Nick on 20/06/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    
   
    //MARK:- Time Ago
    class func timeAgo(_ Min: String) -> String {
        if Min != ""
        {
            let deltaSeconds = (Double(Min))! * 60
            let deltaMinutes: Double = deltaSeconds / 60.0
            var minutes: Int
            if deltaSeconds < 5 {
                return "Just now"
            }
            else if deltaSeconds < 60 {
                return String(format: "%.0f seconds ago", deltaSeconds)
            }
            else if deltaSeconds < 120 {
                return "1 minute ago"
            }
            else if deltaMinutes < 60 {
                return String(format: "%.0f minutes ago", deltaMinutes)
            }
            else if deltaMinutes < 120 {
                return "1 hour ago"
            }
            else if deltaMinutes < (24 * 60) {
                minutes = Int(floor(deltaMinutes / 60))
                return "\(minutes) hours ago"
            }
            else if deltaMinutes < (24 * 60 * 2) {
                return "Yesterday"
            }
            else if deltaMinutes < (24 * 60 * 7) {
                minutes = Int(floor(deltaMinutes / (60 * 24)))
                if minutes == 1
                {
                    return "\(minutes) day ago"
                }else{
                    return "\(minutes) days ago"
                }
            }
            else if deltaMinutes < (24 * 60 * 14) {
                return "Last week"
            }
            else if deltaMinutes < (24 * 60 * 31) {
                minutes = Int(floor(deltaMinutes / (60 * 24 * 7)))
                return "\(minutes) weeks ago"
            }
            else if deltaMinutes < (24 * 60 * 61) {
                return "Last month"
            }
            else if deltaMinutes < (24 * 60 * 365.25) {
                minutes = Int(floor(deltaMinutes / (60 * 24 * 30)))
                return "\(minutes) months ago"
            }
            else if deltaMinutes < (24 * 60 * 731) {
                return "Last year"
            }
            
            minutes = Int(floor(deltaMinutes / (60 * 24 * 365)))
            return "\(minutes) years ago"
        }
        return ""
    }
    //MARK:- Date ConverterFrom String
    class func dateConvertFromString(strDate: String) -> String {
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: strDate)
        
        let components = calendar.dateComponents([.year, .month, .day, .weekOfYear , .hour, .minute, .second], from: date!, to: Date())
        
        dateFormatter.dateFormat = "dd-MM-yyyy 'at' hh:mm a"
        let convertedDate = dateFormatter.string(from: date!)
        if components.day! > 0 {
            if components.day! > 1 {
                dateFormatter.dateFormat = "dd-MM-yyyy 'at' hh:mm a"
                let convertedDate = dateFormatter.string(from: date!)
                return convertedDate
            }
            else {
                dateFormatter.dateFormat = NSLocalizedString("hh:mm a", comment: "hh:mm a")
                let convertedDate = dateFormatter.string(from: date!)
                return "Yesterday at " + convertedDate
            }
        }
        else {
            if (components.hour! >= 2) {
                return "\(components.hour!) hours ago"
            } else if (components.hour! >= 1){
                return "\(components.hour!) hour ago"
            } else if (components.minute! >= 2) {
                return "\(components.minute!) minutes ago"
            } else if (components.minute! >= 1){
                return "\(components.minute!) minute ago"
            } else if (components.second! >= 5) {
                return "\(components.second!) seconds ago"
            } else {
                return "Just now"
            }
        }
        //return convertedDate
    }
    
    //MARK:- GetDate & Time second Method
    class func GetDateTime(second: Int) -> String {
        
        let calender = Calendar.current
        
        let newDate = calender.date(byAdding: .second, value: -second, to: Date())
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' hh:mm a"
        let convertedDate = dateFormatter.string(from: newDate!)
        return convertedDate
    }
    
    //MARK:- Date Converter one Formate to Other Formate
    class func changeDateFormate (_ strDate: String, strFormatter1 strDateFormatter1: String, strFormatter2 strDateFormatter2: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strDateFormatter1
        
        if let date = dateFormatter.date(from: strDate)
        {
            dateFormatter.dateFormat = strDateFormatter2
            
            if let strConvertedDate: String = dateFormatter.string(from: date)
            {
                return strConvertedDate as String
            }
        }
        return ""
    }
    //MARK:- Current Date & Time
    class func getCurrentDateAndTime() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = NSDate ()
        let strCurrentDate :String = formatter.string(from: currentDate as Date)
        return strCurrentDate
    }
    
    //MARK:- GET DAY NAME

    class func getDayNameBy(stringDate: String) -> String {
        
        let df  = DateFormatter()
        df.dateFormat = "MMM dd yyyy HH:mm a"
        let date = df.date(from: stringDate)!
        df.dateFormat = "EEE"
        return df.string(from: date);
    }
    //  local to UTC date
     class func localToUTC(date:String, fromFormat: String, toFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.date
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
   //UTC TO LOCAL
    class func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
   
    
}
