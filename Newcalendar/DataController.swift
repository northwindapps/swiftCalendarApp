//
//  DataViewController.swift
//  calendarchart
//
//  Created by 矢野悠人 on 2017/08/19.
//  Copyright © 2017年 yumiya. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class DataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var serchfield: UITextField!
    @IBOutlet weak var previousYear: UIButton!
    @IBOutlet weak var nextYear: UIButton!
    
    @IBOutlet weak var today: UIButton!
    
    @IBOutlet weak var jsonbutton: UIButton!
    
    @IBOutlet weak var topbutton: UIButton!
    
    var currentmonth: Int = 0
    var currentyear: Int = 0
    var useryear: Int = 2017
    var datearray = [String]()
    var locationstr: String = ""
    var stringcache: String = ""
    
    var table_type = 0
    var musicSound: AVAudioPlayer?
    var getB:Bool = false
    
    /*var Jan = [String]()
    var Feb = [String]()
    var Mar = [String]()
    var Apr = [String]()
    var May = [String]()
    var June = [String]()
    var July = [String]()
    var Aug = [String]()
    var Sep = [String]()
    var Oct = [String]()
    var Nov = [String]()
    var Dec = [String]()*/
    
    let ABCarray = ["A","B","C","D","E","F","G","H","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE"]
    
    var array1  = [String]()
    var array2  = [String]()
    var array3  = [String]()
    var array4  = [String]()
    var array5  = [String]()
    var array6  = [String]()
    var array7  = [String]()
    var Prep_Days_Data = [String]()//1,2,3,4,5
    var Prep_Months_Data = [String]()//Apr Mar May
    var Day_of_Week = [String]()
    var Day_of_Week_location = [Int]()
    
    var text_content = [String]()
    var text_location = [String]()
    
    var search_text_content = [String]()
    var search_text_location = [String]()
    
    
    //
    var str1 = "Jan"
    var str2 = "Feb"
    var str3 = "Mar"
    var str4 = "Apr"
    var str5 = "May"
    var str6 = "June"
    var str7 = "July"
    var str8 = "Aug"
    var str9 = "Sep"
    var str10 = "Oct"
    var str11 = "Nov"
    var str12 = "Dec"

    
    
    @IBOutlet weak var myTableview: UITableView!
    
   
    
    @IBAction func item1action2(_ sender: Any) {
        
        
        //http://qiita.com/fishpilot272/items/b76e62eb82fc8d788da5
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        
        var caution = "CAUTION"
        
        if locationstr.contains("ja")
        {
            caution = "注意"
        }else if locationstr.contains( "fr")
        {
            caution = "MISE EN GARDE"
        }else if locationstr.contains( "zh"){
            
            caution = "警告"
        }else if locationstr.contains( "de")
        {
            caution = "VORSICHT"
        }else if locationstr.contains( "it")
        {
            caution = "ATTENZIONE"
        }else if locationstr.contains( "es")
        {
            caution = "precaución"
        }else{
            
        }
        
        var message = "Do you want to delete all memos?"
        
        if locationstr.contains( "ja")
        {
            message = "すべてのメモを削除しますか？"
        }else if locationstr.contains( "fr")
        {
            message = "Voulez-vous supprimer tous les mémoires?"
        }else if locationstr.contains( "zh"){
            
            message = "要删除所有备忘录吗？"
        }else if locationstr.contains( "de")
        {
            message = "Möchten Sie alle Memos löschen?"
        }else if locationstr.contains( "it")
        {
            message = "eliminare tutti i promemoria?"
        }else if locationstr.contains( "es")
        {
            message = "borrar todas las notas?"
        }else{
            
        }
        
        
        let alert: UIAlertController = UIAlertController(title: caution, message: message, preferredStyle:  UIAlertController.Style.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        
        var ok = "OK"
        
        if locationstr.contains( "ja")
        {
            ok = "はい"
        }else if locationstr.contains( "fr")
        {
            ok = "Oui"
        }else if locationstr.contains( "zh"){
            
            ok = "是"
        }else if locationstr.contains( "de")
        {
            ok = "Ja"
        }else if locationstr.contains( "it")
        {
            ok = "Sì"
        }else if locationstr.contains( "es")
        {
            ok = "Sì"
        }else{
            
        }
        
        let defaultAction: UIAlertAction = UIAlertAction(title: ok, style:UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            
            (action: UIAlertAction!) -> Void in
            //http://yuichi-dev.blogspot.jp/2015/04/swiftnsuserdefaults.html
            // 保存データを全削除
            let userDefault = UserDefaults.standard
            let appDomain:String = Bundle.main.bundleIdentifier!
            userDefault.removePersistentDomain(forName: appDomain)
            
        })
        
        
        
        
        // キャンセルボタン
        
        var ok2 = "No"
        
        if locationstr.contains( "ja")
        {
            ok2 = "いいえ"
        }else if locationstr.contains( "fr")
        {
            ok2 = "Non"
        }else if locationstr.contains( "zh"){
            
            ok2 = "不"
        }else if locationstr.contains( "de")
        {
            ok2 = "Nein"
        }else if locationstr.contains( "it")
        {
            ok2 = "No"
        }else if locationstr.contains( "es")
        {
            ok2 = "No"
        }else{
            
        }
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: ok2, style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
        
        //print("This is 1.")
        
        
        //https://stackoverflow.com/questions/25375409/how-to-switch-view-controllers-in-swift
        //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        //let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        //self.present(resultViewController, animated:true, completion:nil)
        
    }

    override func viewDidLoad() {
        today.setTitle(" Today ", for: .normal)
        today.addTarget(self, action: #selector(getToday), for: .touchUpInside)
        
        let label = UITapGestureRecognizer(target: self, action: #selector(self.tappedcell(_:)))
        myTableview.addGestureRecognizer(label)
        myTableview.delegate = self
        
        let initial = Export()
        (text_location,text_content) = initial.readJsonFIle()
        
        /*
         //https://stackoverflow.com/questions/40392617/swift-3-0-uibarbuttonitem-action-not-work
         item1 = UIBarButtonItem.init(title: "item1", style: .plain, target: self, action: #selector(DataViewController.item1action))
         */
        
        locationstr = Locale.current.languageCode!
        
        //localization
        if let preferredLanguage = NSLocale.preferredLanguages[0] as String? {
            
            locationstr = (NSLocale.preferredLanguages[0] as String?)!
            
            if preferredLanguage.contains("fr"){
                
                str1 = "janv"
                str2 = "févr."
                str3 = "mars"
                str4 = "avr."
                str5 = "mai"
                str6 = "juin"
                str7 = "juil."
                str8 = "août"
                str9 = "sept."
                str10 = "oct"
                str11 = "nov."
                str12 = "déc."
      
            }
            
            if preferredLanguage.contains("ja"){
                
                str1 = "1月"
                str2 = "2月"
                str3 = "3月"
                str4 = "4月"
                str5 = "5月"
                str6 = "6月"
                str7 = "7月"
                str8 = "8月"
                str9 = "9月"
                str10 = "10月"
                str11 = "11月"
                str12 = "12月"
       
                
                
            }
            
            if preferredLanguage.contains("de"){
                
                str1 = "Jan."
                str2 = "Feb."
                str3 = "März"
                str4 = "Apr."
                str5 = "Mai"
                str6 = "Juni"
                str7 = "Juli"
                str8 = "Aug."
                str9 = "Sep."
                str10 = "Okt."
                str11 = "Nov."
                str12 = "Dez."
          
                
                
                
            }
            
            if preferredLanguage.contains("it"){
                
                str1 = "Gen"
                str2 = "Feb"
                str3 = "Mar"
                str4 = "Apr"
                str5 = "Mag"
                str6 = "Giu"
                str7 = "Lug"
                str8 = "Ago"
                str9 = "Set"
                str10 = "Oto"
                str11 = "Nov"
                str12 = "Diz"
      
                
                
                
            }
            
            if preferredLanguage.contains("es"){
                           
                           str1 = "enero"
                           str2 = "febrero"
                           str3 = "marzo"
                           str4 = "abril"
                           str5 = "mayo"
                           str6 = "junio"
                           str7 = "julio"
                           str8 = "agosto"
                           str9 = "sept"
                           str10 = "octubre"
                           str11 = "nov"
                           str12 = "diciembre"
                 
                           
                           
                           
                       }
            
            if preferredLanguage.contains("zh-Hans"){
                
                str1 = "一月"
                str2 = "二月"
                str3 = "三月"
                str4 = "四月"
                str5 = "五月"
                str6 = "六月"
                str7 = "七月"
                str8 = "八月"
                str9 = "九月"
                str10 = "十月"
                str11 = "十一月"
                str12 = "十二月"
           
                
            }
        }
  
        getToday()
        
        serchfield.delegate = self
      
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "stockfoto_44166019_S.jpg")!)
        
        //EntryForm Design
        myTableview.layer.borderWidth = 0
        
        
        //http://stackoverflow.com/questions/27551291/uitableview-backgroundcolor-always-white-on-ipad
        myTableview.layer.borderColor = UIColor.blue.cgColor
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        var tempint = 0
        switch table_type {
        case 0:
            tempint = Prep_Days_Data.count
            break
        case 1:
            tempint = search_text_content.count
            break
        default:
            break
        }
        return tempint
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = myTableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        
        switch table_type {
        case 0:
        var daynumber = 9
        var daystr = ""
        
        if Int(Day_of_Week[indexPath.row]) != nil{
            daynumber = Int(Day_of_Week[indexPath.row])!
        }else{//Sep April, NOV
            daystr = Day_of_Week[indexPath.row]
        }
        
        
        
        //print(daynumber)
        
        switch daynumber {
            
        case 1:
            if locationstr.contains( "ja")
            {
                daystr = "日"
            }else if locationstr.contains( "fr")
            {
                daystr = "dim."
            }else if locationstr.contains( "zh"){
                
                daystr = "周日"
            }else if locationstr.contains( "de")
            {
                daystr = "So"
            }else if locationstr.contains( "it")
            {
                daystr = "Dom"
            }else if locationstr.contains( "es")
            {
                daystr =  "Dom"
            }else{
                daystr = "Sun"
            }
            break
            
        case 2:
            if locationstr.contains( "ja")
            {
                daystr = "月"
            }else if locationstr.contains( "fr")
            {
                daystr = "Lun"
            }else if locationstr.contains( "zh"){
                
                daystr = "周一"
            }else if locationstr.contains( "de")
            {
                daystr = "Mo"
            }else if locationstr.contains( "it")
            {
                daystr = "Lun"
            }else if locationstr.contains( "es")
            {
                daystr = "Lun"
            }else{
                daystr = "Mon"
            }
            break
            
        case 3:
            if locationstr.contains( "ja")
            {
                daystr = "火"
            }else if locationstr.contains( "fr")
            {
                daystr = "Mar"
            }else if locationstr.contains( "zh"){
                
                daystr = "周二"
            }else if locationstr.contains( "de")
            {
                daystr = "Di"
            }else if locationstr.contains( "it")
            {
                daystr = "Mar"
            }else if locationstr.contains( "es")
            {
                daystr = "Mar"
            }else{
                
                
                daystr = "Tue"
            }
            break
        case 4:
            if locationstr.contains( "ja")
            {
                daystr = "水"
            }else if locationstr.contains( "fr")
            {
                daystr = "Mer"
            }else if locationstr.contains( "zh"){
                
                daystr = "周三"
            }else if locationstr.contains( "de")
            {
                daystr = "Mi"
            }else if locationstr.contains( "it")
            {
                daystr = "Mer"
            }else if locationstr.contains( "es")
            {
                daystr = "Mié"
            }else{
                
                
                daystr = "Wed"
            }
            break
        case 5:
            if locationstr.contains( "ja")
            {
                daystr = "木"
            }else if locationstr.contains( "fr")
            {
                daystr = "Jeu"
            }else if locationstr.contains( "zh"){
                
                daystr = "周四"
            }else if locationstr.contains( "de")
            {
                daystr = "Do"
            }else if locationstr.contains( "it")
            {
                daystr = "Gio"
            }else if locationstr.contains( "es")
            {
                daystr = "Jue"
            }else{
                daystr = "Thr"
            }
            break
        case 6:
            if locationstr.contains( "ja")
            {
                daystr = "金"
            }else if locationstr.contains( "fr")
            {
                daystr = "Ven"
            }else if locationstr.contains( "zh")
            {
                
                daystr = "周五"
            }else if locationstr.contains( "de")
            {
                daystr = "Fr"
            }else if locationstr.contains("it")
            {
                daystr = "Ven"
            }else if locationstr.contains("es")
            {
                daystr = "Vie"
            }else{
                daystr = "Fri"
            }
            break
            
        case 0:if locationstr.contains("ja")
        {
            daystr = "土"
        }else if locationstr.contains("fr")
        {
            daystr = "Sam"
        }else if locationstr.contains("zh")
        {
            
            daystr = "周六"
        }else if locationstr.contains("de")
        {
            daystr = "Sa"
        }else if locationstr.contains("it")
        {
            daystr = "Sab"
        }else if locationstr.contains("es")
        {
            daystr = "Sáb"
        }else{
            daystr = "Sat"
        }
            break
            
        default:
            break;
        }
        
        
        
        
        
        //
        //get the current year
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let todayDate = formatter.string(from: date)
        
        var tempMonth = Prep_Months_Data[indexPath.row]
        
        if Prep_Months_Data[indexPath.row].count == 1{
            tempMonth = "0" + Prep_Months_Data[indexPath.row]
        }
        
        var tempDaynumber = Prep_Days_Data[indexPath.row]
        
        if Prep_Days_Data[indexPath.row].count == 1{
            tempDaynumber = "0" + Prep_Days_Data[indexPath.row]
        }
        
        let checkstr = String(currentyear) + "-" + tempMonth + "-" + tempDaynumber
        
        
        if todayDate == checkstr {
            cell.layer.borderWidth = 2
        }else{
            cell.layer.borderWidth = 0
        }
        
        cell.backgroundColor = UIColor.white
        cell.label1.textColor = UIColor.black
        cell.label1plus.textColor = UIColor.black
        cell.label2.textColor = UIColor.black
        
        
        //It's Sunday
        cell.label1.text=daystr
        
        if daystr == "Sun" || daystr == "日" || daystr == "dim." || daystr == "Dom" || daystr == "So" || daystr == "周日"{
            
            cell.label1.textColor = UIColor.red
            
        }
        
        
        
        //cell.label1.textAlignment = NSTextAlignment.left
        cell.label1plus.text = Prep_Days_Data[indexPath.row] //String(indexPath.row+1)
        
        
        
        let keystring = String(useryear) + "/" + Prep_Months_Data[indexPath.row] + "/" + Prep_Days_Data[indexPath.row]
        //print(keystring) 2017/11/32
        
        //
        if text_location.contains(keystring){
        
            let whereitexsit = text_location.index(of: keystring) 
            cell.label2.text = text_content[whereitexsit!]
            
            
        }else{
            cell.label2.text = ""
            
        }
        
        
        // nonToday
        let middleIndex = ((myTableview.indexPathsForVisibleRows?.first?.row)! + (myTableview.indexPathsForVisibleRows?.last?.row)!)/2
        //In Scroll
        let nonToday = String(useryear) + "/" + Prep_Months_Data[middleIndex] + "/" + Prep_Days_Data[middleIndex]
        if nonToday.contains(String(useryear) + "//"){
            dataLabel.text = ""
        }else{
            
            let weekday = getDayOfWeek(today: nonToday)
            let nonTodayFinal = String(useryear) + " " + returnmonth(number: Int(Prep_Months_Data[middleIndex])!-1)  + " " + Prep_Days_Data[middleIndex] + " " + weekDayString(daynumber: weekday!, locationstr: locationstr)
            dataLabel.text = nonTodayFinal
        }
      
        
        //Todayget called
        if getB == true{
            formatter.dateFormat = "yyyy/MM/dd"
            let today = formatter.string(from: date)
            let weekday = getDayOfWeek(today: today)
            dataLabel.text = today + " " + weekDayString(daynumber: weekday!, locationstr: locationstr)
           
        }
        //Month cell
        if Day_of_Week[indexPath.row] == str1 {
          
            cell.backgroundColor = UIColor(red:0.64, green:0.99, blue:0.99, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str2 {
          
            cell.backgroundColor = UIColor(red:0.64, green:0.99, blue:0.99, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if  Day_of_Week[indexPath.row] == str3 {
          
            cell.backgroundColor = UIColor(red:0.64, green:0.99, blue:0.99, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }
        else if Day_of_Week[indexPath.row] == str4{
           
            cell.backgroundColor = UIColor(red:0.62, green:0.94, blue:0.75, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }
        else if Day_of_Week[indexPath.row] == str5 {
        
            cell.backgroundColor = UIColor(red:0.62, green:0.94, blue:0.75, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }
        else if Day_of_Week[indexPath.row] == str6 {
      
            cell.backgroundColor = UIColor(red:0.62, green:0.94, blue:0.75, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }
        else if Day_of_Week[indexPath.row] == str7 {
            
            cell.backgroundColor = UIColor(red:0.34, green:0.80, blue:0.52, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str8 {
            
            cell.backgroundColor = UIColor(red:0.34, green:0.80, blue:0.52, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str9 {
            
            cell.backgroundColor = UIColor(red:0.34, green:0.80, blue:0.52, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str10 {
            
            cell.backgroundColor = UIColor(red:0.97, green:0.96, blue:0.70, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str11 {
         
            cell.backgroundColor = UIColor(red:0.97, green:0.96, blue:0.70, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }else if Day_of_Week[indexPath.row] == str12 {
         
            cell.backgroundColor = UIColor(red:0.97, green:0.96, blue:0.70, alpha:1.0)
            cell.label1.font = UIFont.systemFont(ofSize: 18)
            cell.label1.font = UIFont(name: "Times New Roman", size: cell.label1.font.pointSize)
            
        }
        else{
            cell.label1.font = UIFont.systemFont(ofSize: 17)
        }
        
        
            break
        case 1:
            cell.label1.text = search_text_location[indexPath.row]
            cell.label1.font = UIFont.systemFont(ofSize: 9)
            cell.label1plus.text = ""
            cell.label2.text = search_text_content[indexPath.row]
            break
        default:
            break
        }
        
        //
        let receivedstr = String(useryear) + "/" + Prep_Months_Data[indexPath.row] + "/" + Prep_Days_Data[indexPath.row]
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filename = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a"
        
        let filePath = url.appendingPathComponent(filename).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            //print("FILE AVAILABLE")
            cell.playback.textColor = UIColor.black
        } else {
            //print("FILE NOT AVAILABLE")
            cell.playback.textColor = UIColor.clear
        }
        
        return cell
    }
    
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        table_type = 1
        
        search_text_location.removeAll()
        search_text_content.removeAll()
        
        var tempstr = textField.text!
        
        tempstr = tempstr.replacingOccurrences(of: " ", with: "")
        
        if tempstr.count > 0{
        
        for i in 0..<text_content.count {
      
            if text_content[i].contains(tempstr){
                search_text_content.append(text_content[i])
                search_text_location.append(text_location[i])
            }
            
        }
        
            if search_text_location.count>0{
                
            }else{
                table_type = 0
                textField.text = ""
            }
            myTableview.reloadData()
        }else{
            textField.text = ""
            table_type = 0
        }
        return true
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
    
    
    // hides text views
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        
        if (text == "\n") {
            //あなたのテキストフィールド
            myTableview.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    //https://stackoverflow.com/questions/39015228/detect-when-uitableview-has-scrolled-to-the-bottom
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    
    func calendarcreation(){
        
        //get the current year
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM"
        
        var thisMonth = formatter.string(from: date)
        
        
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
            
            switch i {
            case 0:
                Day_of_Week.append(str1)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 1:
                Day_of_Week.append(str2)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 2:
                Day_of_Week.append(str3)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 3:
                Day_of_Week.append(str4)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 4:
                Day_of_Week.append(str5)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 5:
                Day_of_Week.append(str6)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 6:
                Day_of_Week.append(str7)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 7:
                Day_of_Week.append(str8)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 8:
                Day_of_Week.append(str9)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 9:
                Day_of_Week.append(str10)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 10:
                Day_of_Week.append(str11)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            case 11:
                Day_of_Week.append(str12)
                Day_of_Week_location.append(Day_of_Week.count)
                break
            default :
                break
            }
            
            
            
            Prep_Days_Data.append("")//Sun Mon Tue Wed
            Prep_Months_Data.append("")//Jan Feb
            
            
            for j in 0..<daysnumber[i]{
                Prep_Days_Data.append(String(j+1))
                
                let temp = (daynumbers[i] + counter)%7
                Day_of_Week.append(String(temp))//Sun Mon
                
                Prep_Months_Data.append(String(i+1))//Jan Feb
                counter += 1
            }
            
            
        }
        
        formatter.dateFormat = "dd"
        
        var dd = formatter.string(from: date)
        
        let appd : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch appd.returnstr {
        case -1:
            break
        default:
            thisMonth = String(appd.returnMM)
            dd = String(appd.returnDD)
            break
        }
        
        // About 370..
        for i in 0..<Prep_Months_Data.count{
            
            // Jan Jan Jan...31 times
            if Prep_Months_Data[i]  == thisMonth{
                
                appd.scrollposition = i-31+Int(dd)!
            }else if "0" + Prep_Months_Data[i]  == thisMonth{
                
                appd.scrollposition = i-31+Int(dd)!
            }
            
            //Index Error
            if appd.scrollposition < 0 {
                // It's impossible...
                appd.scrollposition = 1
            }
            
        }
    }
    
    
    @IBAction func nextYearaction(_ sender: Any) {
        useryear += 1
    
        calendarcreation()
        
        table_type = 0
        
        myTableview.reloadData()
    
    }
    
    @objc func getToday() {
        //get the current year. user get the current year whenever they live
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let yearstring = formatter.string(from: date)
        // convert to Integer
        currentyear = Int(yearstring)!
      
        
        
        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        switch AppDel.returnstr {
        case -1:
            getB = true
         
            useryear = currentyear
            break
        default:
            useryear = AppDel.returnstr
            break
        }
            
            calendarcreation()
            
            table_type = 0
            
            myTableview.reloadData()
            
            let indexPath = NSIndexPath(item: AppDel.scrollposition, section: 0)
        myTableview.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.top, animated: true)
            
            AppDel.firstlaunch = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // in half a second...//https://stackoverflow.com/questions/37801370/how-do-i-dispatch-sync-dispatch-async-dispatch-after-etc-in-swift-3-swift-4
                print("Are we there yet?")
                self.getB = false
            }
        
        AppDel.returnstr = -1
    }
    
    @IBAction func jsonaction(_ sender: Any) {
        
        
        
//        let temp = Export()
//        temp.saveJsonFile(source: jsoned as! Dictionary<String, String>)
//
//        temp.readJsonFIle()
        
        let targetViewController = self.storyboard!.instantiateViewController( withIdentifier: "MailView" )
        self.present( targetViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func previousYearaction(_ sender: Any) {

        useryear -= 1
        
        calendarcreation()
        
        table_type = 0
        
        myTableview.reloadData()
    }
    
    @IBAction func GoTop(_ sender: Any) {
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "mainview") as! MainViewController
        self.present(resultViewController, animated:true, completion:nil)
    }
    @objc func tappedcell(_ sender : UITapGestureRecognizer ){
        //Common part
        let tableview = sender.view as! UITableView
        let p = sender.location(in: sender.view)
        let indexPath = tableview .indexPathForRow(at: p)
    
        tableview .deselectRow(at: indexPath!, animated: false)
        
        let cell = tableview.cellForRow(at: indexPath!) as! TableViewCell
        let pointInCell = sender.location(in: cell) as CGPoint
        
        if (cell.playback.frame.contains(pointInCell))
        { // user tapped image
            
            musicSound?.stop()
            playMusic(indexPath: indexPath!)
            
        }else {
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
            
            switch table_type {
            case 0:
                resultViewController.receivedstr = String(useryear) + "/" + Prep_Months_Data[(indexPath?.row)!] + "/" + Prep_Days_Data[(indexPath?.row)!]
                resultViewController.receivedyear = useryear
                if Int(Prep_Months_Data[(indexPath?.row)!]) != nil{
                    resultViewController.returnMM = Int(Prep_Months_Data[(indexPath?.row)!])
                }
                if Int(Prep_Days_Data[(indexPath?.row)!]) != nil{
                    resultViewController.returnDD = Int(Prep_Days_Data[(indexPath?.row)!])
                }
                resultViewController.table_type = table_type
                resultViewController.useryear = useryear
                resultViewController.daysArray = Prep_Days_Data
                resultViewController.monthsArray = Prep_Months_Data
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                break
            case 1:
                resultViewController.receivedstr = search_text_location[(indexPath?.row)!]
                resultViewController.receivedyear = useryear
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "MM"
                let mmString = formatter.string(from: date)
                resultViewController.returnMM = Int(mmString)!
                
                formatter.dateFormat = "dd"
                let ddString = formatter.string(from: date)
                resultViewController.returnDD = Int(ddString)!
                
                resultViewController.table_type = table_type
                resultViewController.useryear = useryear
                resultViewController.indexofTable = -1

                resultViewController.daysArray = Prep_Days_Data
                resultViewController.monthsArray = Prep_Months_Data
                resultViewController.text_content = text_content//ok
                resultViewController.text_location = text_location//ok
                break
            default:
                break
            }
        
            self.present(resultViewController, animated:true, completion:nil)
           
        }
        
    }
    
    //player
    func playMusic(indexPath: IndexPath) {
        
        var receivedstr = ""
        switch table_type {
        case 0:
            receivedstr = String(useryear) + "/" + Prep_Months_Data[indexPath.row] + "/" + Prep_Days_Data[indexPath.row]
            break
        case 1:
            receivedstr =  search_text_location[(indexPath.row)]
            break
        default:
            break
            
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent(receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a")
        
        //let path = Bundle.main.path(forResource: "easy-lemon.mp3", ofType: nil)!
        let url = audioFilename
        
        do {
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        } catch {
            //couldn't load file :(
        }
    }
    
    
    //getDocuments
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func weekDayString(daynumber:Int, locationstr:String) -> String{
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
            }else{
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
                return "Mer"
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
                return "jeu."
            }else if locationstr.contains( "zh"){
                
                return  "周四"
            }else if locationstr.contains( "de")
            {
                return  "Do"
            }else if locationstr.contains( "it")
            {
                return "Gio"
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
                return  "Ven"
            }else if locationstr.contains("es")
            {
                return  "Vie"
            }else{
                return  "Fri"
            }
           
        case 7:
            if locationstr.contains("ja")
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
            }else{
                return "Sat"
            }
            
        default:
            return " "
        }
    }
   
    
    func returnmonth(number:Int)->(String){
        switch number {
        case 0:
            return str1
            
        case 1:
            return str2
            
        case 2:
            return str3
            
        case 3:
            return str4
            
        case 4:
            return str5
            
        case 5:
            return str6
            
        case 6:
            return str7
            
        case 7:
            return str8
            
        case 8:
            return str9
            
        case 9:
            return str10
            
        case 10:
            return str11
            
        case 11:
            return str12
            
        default:
            return "Error"
            
        }
    }
    
}

