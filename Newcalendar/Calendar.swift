//
//  Calendar.swift
//  Newcalendar
//
//  Created by yujin on 2019/12/20.
//  Copyright © 2019 yujinyano. All rights reserved.
//

import UIKit
import Foundation

class CalendarData {
    
   
    
    func calendarcreation(useryear:Int) -> ([String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String], [String],[String], [String], Int){
        
        let useryear: Int = useryear
        var Prep_Days_Data = [String]()//1,2,3,4,5
        var Prep_Months_Data = [String]()//Apr Mar May
        var Day_of_Week = [String]()
        var Day_of_Week_location = [Int]()
        
        //
        var col0 = [String]()
        var col1 = [String]()
        var col2 = [String]()
        var col3 = [String]()
        var col4 = [String]()
        var col5 = [String]()
        var col6 = [String]()
        
        var ym0 = [String]()
        var ym1 = [String]()
        var ym2 = [String]()
        var ym3 = [String]()
        var ym4 = [String]()
        var ym5 = [String]()
        var ym6 = [String]()
        
        
        //get the current year
        let yearnumber = useryear
        var daysnumber = [Int]()
        var daynumbers = [Int]()
        
        //2,4,6,9,11 → 30
        for i in 1..<13{
            
            var calday = String(yearnumber) + "-" + String(i) + "-01"
            
            if i < 10 {
                calday = String(yearnumber) + "-0" + String(i) + "-01"
            }else{
                
            }
            
            
            let daynumber : Int = getDayOfWeek(today: calday)!
            //print(daynumber)
            
            switch i {
            case 2:
                
                if yearnumber%400==0{
                    
                    daysnumber.append(29)
                    daynumbers.append(daynumber)
                    
                }
                else if yearnumber%100==0{
                    
                    daysnumber.append(28)
                    daynumbers.append(daynumber)
                    
                }else if yearnumber%4==0{
                    
                    daysnumber.append(29)
                    daynumbers.append(daynumber)
                    
                }else{
                    
                    daysnumber.append(28)
                    daynumbers.append(daynumber)
                    
                }
            case 4:
                daysnumber.append(30)
                daynumbers.append(daynumber)
                
            case 6:
                
                daysnumber.append(30)
                daynumbers.append(daynumber)
                
            case 9:
                
                daysnumber.append(30)
                daynumbers.append(daynumber)
                
            case 11:
                
                daysnumber.append(30)
                daynumbers.append(daynumber)
                
            default://other months have 31 days
                
                daysnumber.append(31)
                daynumbers.append(daynumber)
                
            }
            
        }
        
        
        
        //print(daysnumber)//count of a month numbers
        //print(daynumbers)
        
        Prep_Days_Data.removeAll()
        Prep_Months_Data.removeAll()
        Day_of_Week.removeAll()
        Day_of_Week_location.removeAll()
        
        
        
        
        
        for i in 0..<12 {
            
            var counter = 0
            let janStr = localization(num: 1)
            //Opening
            if i == 0 {
                Prep_Days_Data.append("?" + String(useryear) + " " + janStr)
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
            }
            
            //Padding before starting
            var datestr = String(useryear) + "-" + String(i+1) + "-01"
            if String(i+1).count == 1 {
                datestr = String(useryear) + "-0" + String(i+1) + "-01"
            }
            let firstweek : Int = getDayOfWeek(today: datestr)!
            
            switch firstweek {
            case 1:
                break
            case 2:
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                break
            case 3:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 4:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 5:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 6:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 7:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            default:
                break
            }
           
            for j in 0..<daysnumber[i]{
                Prep_Days_Data.append(String(j+1))
                Prep_Months_Data.append(String(i+1))//Jan Feb
                counter += 1
            }
            
            //Padding after a loop
            var datestr2 = String(useryear) + "-" + String(i+1) + "-" + String(Prep_Days_Data.last!)
            if String(i+1).count == 1 {
                datestr2 = String(useryear) + "-0" + String(i+1) + "-" + String(Prep_Days_Data.last!)
            }
            let lastweek : Int = getDayOfWeek(today: datestr2)!
            
            //This next label
            var nextMonthis = localization(num:(Int(Prep_Months_Data.last!)! + 1))
            
            switch lastweek {
            case 1:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 2:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 3:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 4:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 5:
                Prep_Days_Data.append("")
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                Prep_Months_Data.append("")
                break
            case 6:
                Prep_Days_Data.append("")
                Prep_Months_Data.append("")
                break
            case 7:
                break
            default:
                break
            }
            
            //closing
            var nmL = "?"
            var useryear2 = String(useryear)
            if nextMonthis == "null"{
               nextMonthis = ""
                nmL = ""
                useryear2 = ""
            }
            Prep_Days_Data.append(nmL + useryear2 + " " + nextMonthis  )
            Prep_Days_Data.append("")
            Prep_Days_Data.append("")
            Prep_Days_Data.append("")
            Prep_Days_Data.append("")
            Prep_Days_Data.append("")
            Prep_Days_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            Prep_Months_Data.append("")
            
            
        }
        
       
        var presentDayforTable = 0
        
        for i in 0 ..< Prep_Days_Data.count {
            if i%7 == 0 {
                col0.append(Prep_Days_Data[i])
                ym0.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym0.last{
                    presentDayforTable = ym0.count
                }
                
            }else if i%7 == 1 {
                col1.append(Prep_Days_Data[i])
                ym1.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym1.last{
                    presentDayforTable = ym1.count
                }
            }else if i%7 == 2 {
                col2.append(Prep_Days_Data[i])
                ym2.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym2.last{
                    presentDayforTable = ym2.count
                }
            }else if i%7 == 3 {
                col3.append(Prep_Days_Data[i])
                ym3.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym3.last{
                    presentDayforTable = ym3.count
                }
            }else if i%7 == 4 {
                col4.append(Prep_Days_Data[i])
                ym4.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym4.last{
                    presentDayforTable = ym4.count
                }
            }else if i%7 == 5 {
                col5.append(Prep_Days_Data[i])
                ym5.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym5.last{
                    presentDayforTable = ym5.count
                }
            }else if i%7 == 6 {
                col6.append(Prep_Days_Data[i])
                ym6.append(String(useryear) + "/" + Prep_Months_Data[i] + "/" + Prep_Days_Data[i])
                if getToday() == ym6.last{
                    presentDayforTable = ym6.count
                }
            }
        }
        
//       print(Prep_Months_Data)
//       print(Prep_Days_Data)
  
        return (col0 ,col1,col2, col3, col4, col5, col6, ym0, ym1, ym2, ym3, ym4, ym5, ym6, Prep_Months_Data, Prep_Days_Data, presentDayforTable)
    }
    
    //https://stackoverflow.com/questions/25533147/get-day-of-week-using-nsdate-swift
    func getDayOfWeek(today:String) -> Int? {//1to7
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func localization (num:Int) -> String{
      
        
//        var locationstr = Locale.current.languageCode!
        
        //localization
        if let preferredLanguage = NSLocale.preferredLanguages[0] as String? {
            
            if preferredLanguage.contains("fr"){
                
                switch num {
                case 1:
                    return "janv"
                case 2:
                    return "févr."
                case 3:
                    return "mars"
                case 4:
                    return "avr."
                case 5:
                    return "mai"
                case 6:
                    return "juin"
                case 7:
                    return "juil."
                case 8:
                    return "août."
                case 9:
                    return "sept."
                case 10:
                    return "oct."
                case 11:
                    return "nov."
                case 12:
                    return "déc."
                default:
                    return "null"
                
                }
            }
            
            else if preferredLanguage.contains("en"){
                
                switch num {
                case 1:
                    return "Jan"
                case 2:
                    return "Feb"
                case 3:
                    return "Mar"
                case 4:
                    return "Apr"
                case 5:
                    return "May"
                case 6:
                    return "Jun"
                case 7:
                    return "Jul"
                case 8:
                    return "Aug"
                case 9:
                    return "Sep"
                case 10:
                    return "Oct"
                case 11:
                    return "Nov"
                case 12:
                    return "Dec"
                default:
                    return "null"
                    
                }
            }
            
            else if preferredLanguage.contains("ja"){
                
                switch num {
                case 1:
                    return "1月"
                case 2:
                    return "2月"
                case 3:
                    return "3月"
                case 4:
                    return "4月"
                case 5:
                    return "5月"
                case 6:
                    return "6月"
                case 7:
                    return "7月"
                case 8:
                    return "8月"
                case 9:
                    return "9月"
                case 10:
                    return "10月"
                case 11:
                    return "11月"
                case 12:
                    return "12月"
                default:
                    return "null"
              
                }
            }
            
            else if preferredLanguage.contains("de"){
                switch num {
                case 1:
                    return "Jan."
                case 2:
                    return "Feb."
                case 3:
                    return "März"
                case 4:
                    return "Apr."
                case 5:
                    return "Mai"
                case 6:
                    return "Juni"
                case 7:
                    return "Juli"
                case 8:
                    return "Aug."
                case 9:
                    return "Sep."
                case 10:
                    return "Okt."
                case 11:
                    return "Nov."
                case 12:
                    return "Dez."
                default:
                    return "null"
                
                }
            }
            
            else if preferredLanguage.contains("it"){
                switch num {
                case 1:
                    return "Gen"
                case 2:
                    return "Feb"
                case 3:
                    return "Mar"
                case 4:
                    return "Apr"
                case 5:
                    return "Mag"
                case 6:
                    return "Giu"
                case 7:
                    return "Lug"
                case 8:
                    return "Ago"
                case 9:
                    return "Set"
                case 10:
                    return "Oto"
                case 11:
                    return "Nov"
                case 12:
                    return "Diz"
                default:
                    return "null"
            
                }
            }
            
            else if preferredLanguage.contains("zh-Hans"){
                switch num {
                case 1:
                    return "一月"
                case 2:
                    return "二月"
                case 3:
                    return "三月"
                case 4:
                    return "四月"
                case 5:
                    return "五月"
                case 6:
                    return "六月"
                case 7:
                    return "七月"
                case 8:
                    return "八月"
                case 9:
                    return "九月"
                case 10:
                    return "十月"
                case 11:
                    return "十一月"
                case 12:
                    return "十二月"
                default:
                    return "null"
                 
                }
            }
                
            else if preferredLanguage.contains("es"){
                switch num {
                case 1:
                    return "enero"
                case 2:
                    return "febrero"
                case 3:
                    return "marzo"
                case 4:
                    return "abril"
                case 5:
                    return "mayo"
                case 6:
                    return "junio"
                case 7:
                    return "julio"
                case 8:
                    return "agosto"
                case 9:
                    return "sept"
                case 10:
                    return "octubre"
                case 11:
                    return "nov"
                case 12:
                    return "diciembre"
                default:
                    return "null"
                 
                }
            }
            
            else{
                
                switch num {
                case 1:
                    return "Jan"
                case 2:
                    return "Feb"
                case 3:
                    return "Mar"
                case 4:
                    return "Apr"
                case 5:
                    return "May"
                case 6:
                    return "Jun"
                case 7:
                    return "Jul"
                case 8:
                    return "Aug"
                case 9:
                    return "Sep"
                case 10:
                    return "Oct"
                case 11:
                    return "Nov"
                case 12:
                    return "Dec"
                default:
                    return "null"
                    
                }
            }
            
        }
        return "null"
    }
    
    
    func localization_dayofweek(daynumber: Int)-> String {
        
        let locationstr = (NSLocale.preferredLanguages[0] as String?)!
        
        switch daynumber {
            
        case 1:
            if locationstr.contains( "ja")
            {
                return  "日"
            }else if locationstr.contains( "fr")
            {
                return  "dim."
            }else if locationstr.contains( "zh"){
                
                return  "周日"
            }else if locationstr.contains( "de")
            {
                return  "So"
            }else if locationstr.contains( "it")
            {
                return  "Dom"
            }else if locationstr.contains( "es")
            {
                return  "Dom"
            }
            else{
                return  "Sun"
            }
       
            
        case 2:
            if locationstr.contains( "ja")
            {
                return  "月"
            }else if locationstr.contains( "fr")
            {
                return  "lun."
            }else if locationstr.contains( "zh"){
                
                return  "周一"
            }else if locationstr.contains( "de")
            {
                return  "Mo"
            }else if locationstr.contains( "it")
            {
                return  "Lun"
            }else if locationstr.contains( "es")
            {
                return  "Lun"
            }else{
                return  "Mon"
            }

            
        case 3:
            if locationstr.contains( "ja")
            {
                return  "火"
            }else if locationstr.contains( "fr")
            {
                return  "mar."
            }else if locationstr.contains( "zh"){
                
                return  "周二"
            }else if locationstr.contains( "de")
            {
                return  "Di"
            }else if locationstr.contains( "it")
            {
                return  "Mar"
            }else if locationstr.contains( "es")
            {
                return  "Mar"
            }else{
                
                
                return  "Tue"
            }
   
        case 4:
            if locationstr.contains( "ja")
            {
                return  "水"
            }else if locationstr.contains( "fr")
            {
                return  "mer."
            }else if locationstr.contains( "zh"){
                
                return  "周三"
            }else if locationstr.contains( "de")
            {
                return  "Mi"
            }else if locationstr.contains( "it")
            {
                return  "Mer"
            }else if locationstr.contains( "es")
            {
                return  "Mié"
            }else{
                
                
                return  "Wed"
            }
      
        case 5:
            if locationstr.contains( "ja")
            {
                return  "木"
            }else if locationstr.contains( "fr")
            {
                return  "jeu."
            }else if locationstr.contains( "zh"){
                
                return  "周四"
            }else if locationstr.contains( "de")
            {
                return  "Do"
            }else if locationstr.contains( "it")
            {
                return  "Gio"
            }else if locationstr.contains( "es")
            {
                return  "Jue"
            }else{
                return  "Thr"
            }
     
        case 6:
            if locationstr.contains( "ja")
            {
                return  "金"
            }else if locationstr.contains( "fr")
            {
                return  "ven."
            }else if locationstr.contains( "zh")
            {
                
                return  "周五"
            }else if locationstr.contains( "de")
            {
                return  "Fr"
            }else if locationstr.contains("it")
            {
                return  "ven"
            }else if locationstr.contains("es")
            {
                return  "Vie"
            }else{
                return  "Fri"
            }

        case 7:if locationstr.contains("ja")
        {
            return  "土"
        }else if locationstr.contains("fr")
        {
            return  "sam."
        }else if locationstr.contains("zh")
        {
            
            return  "周六"
        }else if locationstr.contains("de")
        {
            return  "Sa"
        }else if locationstr.contains("it")
        {
            return  "Sab"
        }else if locationstr.contains("es")
        {
            return "Sáb"
        }
        else{
            return  "Sat"
        }
            
        default:
            break;
        }
        
        
        return "null"
        
        
    }
    
    
    @objc func getToday()->String{
        //get the current year. user get the current year whenever they live
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
        
    }
}
