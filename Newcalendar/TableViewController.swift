//
//  TableViewController.swift
//  Newcalendar
//
//  Created by yujin on 2019/12/19.
//  Copyright © 2019 yujinyano. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var homebutton: UIButton!
    
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var thr: UIButton!
    
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var mon: UIButton!
    
    var col0 = [String]()//1,2,3,4,5
    var col1 = [String]()//Apr Mar Mayvar col0 = [String]()
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
    
    var useryear = 0
    var MMArray = [String]()
    var DDArray = [String]()
    
    var text_content = [String]()
    var text_location = [String]()
    
    var presentDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.rowHeight = 80.0
        self.myTable.allowsSelection = false
        
        //
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let thisyear = formatter.string(from: date)
        
        
        var col0_a = [String]()
        var col1_a = [String]()
        var col2_a = [String]()
        var col3_a = [String]()
        var col4_a = [String]()
        var col5_a = [String]()
        var col6_a = [String]()
        
        var ym0_a = [String]()
        var ym1_a = [String]()
        var ym2_a = [String]()
        var ym3_a = [String]()
        var ym4_a = [String]()
        var ym5_a = [String]()
        var ym6_a = [String]()
        
        var MMArray_a = [String]()
        var DDArray_a = [String]()
        
        var col0_b = [String]()
        var col1_b = [String]()
        var col2_b = [String]()
        var col3_b = [String]()
        var col4_b = [String]()
        var col5_b = [String]()
        var col6_b = [String]()
        
        var ym0_b = [String]()
        var ym1_b = [String]()
        var ym2_b = [String]()
        var ym3_b = [String]()
        var ym4_b = [String]()
        var ym5_b = [String]()
        var ym6_b = [String]()
        
        var MMArray_b = [String]()
        var DDArray_b = [String]()
        
        var pDay = 0
        var pDay2 = 0
        
        let cal = CalendarData()
        (col0_a,col1_a,col2_a,col3_a,col4_a,col5_a,col6_a, ym0_a, ym1_a, ym2_a, ym3_a, ym4_a, ym5_a, ym6_a, MMArray_a, DDArray_a, pDay) = cal.calendarcreation(useryear: Int(thisyear)!)
        
        (col0_b,col1_b,col2_b,col3_b,col4_b,col5_b,col6_b, ym0_b, ym1_b, ym2_b, ym3_b, ym4_b, ym5_b, ym6_b, MMArray_b, DDArray_b, pDay2) = cal.calendarcreation(useryear: Int(thisyear)! + 1)

        col0 = col0_a + col0_b
        col1 = col1_a + col1_b
        col2 = col2_a + col2_b
        col3 = col3_a + col3_b
        col4 = col4_a + col4_b
        col5 = col5_a + col5_b
        col6 = col6_a + col6_b
        
        ym0 = ym0_a + ym0_b
        ym1 = ym1_a + ym1_b
        ym2 = ym2_a + ym2_b
        ym3 = ym3_a + ym3_b
        ym4 = ym4_a + ym4_b
        ym5 = ym5_a + ym5_b
        ym6 = ym6_a + ym6_b
        
        MMArray = MMArray_a + MMArray_b
        DDArray = DDArray_a + DDArray_b
        
        if pDay2 > pDay{
           presentDay = pDay2
        }else{
           presentDay = pDay
        }
        
        
        // labelTapped action
        let label = UITapGestureRecognizer(target: self, action: #selector(self.tappedcell(_:)))
        myTable.addGestureRecognizer(label)
        
        
        
        // Do any additional setup after loading the view.
        let initial = Export()
        (text_location,text_content) = initial.readJsonFIle()
        
        //
        
        
        //this will do? I bet
        let presentIndex = NSIndexPath(item: presentDay, section: 0)
        myTable.scrollToRow(at: presentIndex as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        
        let p = getToday()
        let p_num = cal.getDayOfWeek(today: p)
        let p_final = cal.localization_dayofweek(daynumber:p_num!)
        homebutton.setTitle(getToday() + " " + p_final, for: .normal)
        
        sun.setTitle(cal.localization_dayofweek(daynumber: 1), for: .normal)
        mon.setTitle(cal.localization_dayofweek(daynumber: 2), for: .normal)
        tue.setTitle(cal.localization_dayofweek(daynumber: 3), for: .normal)
        wed.setTitle(cal.localization_dayofweek(daynumber: 4), for: .normal)
        thr.setTitle(cal.localization_dayofweek(daynumber: 5), for: .normal)
        fri.setTitle(cal.localization_dayofweek(daynumber: 6), for: .normal)
        sat.setTitle(cal.localization_dayofweek(daynumber: 7), for: .normal)
        
        sun.addTarget(self, action: #selector(self.bTT) , for: .touchUpInside)
        mon.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
        tue.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
        wed.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
        thr.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
        fri.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
        sat.addTarget(self, action: #selector(self.bTT), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return col0.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if col0[indexPath.row].first == "?"{
            return 30.0
        }else{
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCellLS = myTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCellLS
        
        
        cell.M1.numberOfLines = 0
        cell.M1.lineBreakMode = .byWordWrapping
        cell.M2.numberOfLines = 0
        cell.M2.lineBreakMode = .byWordWrapping
        cell.M3.numberOfLines = 0
        cell.M3.lineBreakMode = .byWordWrapping
        cell.M4.numberOfLines = 0
        cell.M4.lineBreakMode = .byWordWrapping
        cell.M5.numberOfLines = 0
        cell.M5.lineBreakMode = .byWordWrapping
        cell.M6.numberOfLines = 0
        cell.M6.lineBreakMode = .byWordWrapping
        cell.M7.numberOfLines = 0
        cell.M7.lineBreakMode = .byWordWrapping
        
        cell.L1.numberOfLines = 0
        cell.L1.lineBreakMode = .byWordWrapping
        
        
        cell.S1.text = col0[indexPath.row]
        cell.S2.text = col1[indexPath.row]
        cell.S3.text = col2[indexPath.row]
        cell.S4.text = col3[indexPath.row]
        cell.S5.text = col4[indexPath.row]
        cell.S6.text = col5[indexPath.row]
        cell.S7.text = col6[indexPath.row]
        
        cell.M1.text = ym0[indexPath.row]
        cell.M2.text = ym1[indexPath.row]
        cell.M3.text = ym2[indexPath.row]
        cell.M4.text = ym3[indexPath.row]
        cell.M5.text = ym4[indexPath.row]
        cell.M6.text = ym5[indexPath.row]
        cell.M7.text = ym6[indexPath.row]
        
        if col0[indexPath.row].first == "?"{
            cell.L1.text = col0[indexPath.row].replacingOccurrences(of: "?", with: "")
            cell.L1.textColor = UIColor.red
        
            cell.M1.text = ""
      
            cell.S1.text = ""
          
            
         
            cell.M2.text = ""
            cell.M3.text = ""
            cell.M4.text = ""
            cell.M5.text = ""
            cell.M6.text = ""
            cell.M7.text = ""
         
            cell.S2.text = ""
            cell.S3.text = ""
            cell.S4.text = ""
            cell.S5.text = ""
            cell.S6.text = ""
            cell.S7.text = ""
          
            
        }else{
            cell.L1.text = ""
           
            
        }
        
        //Main Content
        if text_location.contains(ym0[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym0[indexPath.row])
            cell.M1.text = text_content[indexOfA!]
        }else{
            cell.M1.text = ""
        }
        
        if text_location.contains(ym1[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym1[indexPath.row])
            cell.M2.text = text_content[indexOfA!]
        }else{
            cell.M2.text = ""
        }
        
        if text_location.contains(ym2[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym2[indexPath.row])
            cell.M3.text = text_content[indexOfA!]
        }else{
            cell.M3.text = ""
        }
        
        if text_location.contains(ym3[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym3[indexPath.row])
            cell.M4.text = text_content[indexOfA!]
        }else{
            cell.M4.text = ""
        }
        
        if text_location.contains(ym4[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym4[indexPath.row])
            cell.M5.text = text_content[indexOfA!]
        }else{
            cell.M5.text = ""
        }
        
        if text_location.contains(ym5[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym5[indexPath.row])
            cell.M6.text = text_content[indexOfA!]
        }else{
            cell.M6.text = ""
        }
        
        if text_location.contains(ym6[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym6[indexPath.row])
            cell.M7.text = text_content[indexOfA!]
        }else{
            cell.M7.text = ""
        }
        
//        if ym0[indexPath.row] == getToday(){
//            cell.L1.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L1.layer.borderWidth = 0.0
//        }
//
//        if ym1[indexPath.row] == getToday(){
//            cell.L2.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L2.layer.borderWidth = 0.0
//        }
//
//        if ym2[indexPath.row] == getToday(){
//            cell.L3.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L3.layer.borderWidth = 0.0
//        }
//
//        if ym3[indexPath.row] == getToday(){
//            cell.L4.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L4.layer.borderWidth = 0.0
//        }
//
//        if ym4[indexPath.row] == getToday(){
//            cell.L5.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L5.layer.borderWidth = 0.0
//        }
//
//        if ym5[indexPath.row] == getToday(){
//            cell.L6.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L6.layer.borderWidth = 0.0
//        }
//
//        if ym6[indexPath.row] == getToday(){
//            cell.L7.layer.borderWidth = 2.0
//            presentDay = indexPath.row
//        }else{
//            cell.L7.layer.borderWidth = 0.0
//        }
//
        
        
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func getToday()->String{
        //get the current year. user get the current year whenever they live
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
       
    }
    
    @objc func tappedcell(_ sender : UITapGestureRecognizer ){
        
        let p = sender.location(in: sender.view)
        let indexPath = myTable .indexPathForRow(at: p)
        myTable.deselectRow(at: indexPath!, animated: false)
        
        let cell = myTable.cellForRow(at: indexPath!) as! TableViewCellLS
        let pointInCell = sender.location(in: cell) as CGPoint
        
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        if (cell.M1.frame.contains(pointInCell))
        {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym0[indexPath!.row]) != nil {
                
            
            resultViewController.receivedstr = ym0[indexPath!.row]
            
            let ArrayyyyMMDD = ym0[indexPath!.row].components(separatedBy: "/")
            
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
           
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
           
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (indexPath?.row)!
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
                
            self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M2.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym1[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym1[indexPath!.row]
                
                let ArrayyyyMMDD = ym1[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                //            resultViewController.dayofWeekArray = Day_of_Week
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M3.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym2[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym2[indexPath!.row]
                
                let ArrayyyyMMDD = ym2[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
               
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M4.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym3[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym3[indexPath!.row]
                
                let ArrayyyyMMDD = ym3[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M5.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym4[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym4[indexPath!.row]
                
                let ArrayyyyMMDD = ym4[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M6.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym5[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym5[indexPath!.row]
                
                let ArrayyyyMMDD = ym5[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
        
        if (cell.M7.frame.contains(pointInCell))
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy/MM/dd"
            if dateFormatterGet.date(from: ym6[indexPath!.row]) != nil {
                
                
                resultViewController.receivedstr = ym6[indexPath!.row]
                
                let ArrayyyyMMDD = ym6[indexPath!.row].components(separatedBy: "/")
                
                resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
                
                //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
                
                
                resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
                resultViewController.returnDD = Int(ArrayyyyMMDD[2])
                resultViewController.table_type = 0
                resultViewController.useryear = Int(ArrayyyyMMDD[0])!
                resultViewController.indexofTable = (indexPath?.row)!
                resultViewController.daysArray = DDArray
                resultViewController.monthsArray = MMArray
                resultViewController.text_content = text_content
                resultViewController.text_location = text_location
                
                self.present(resultViewController, animated:true, completion:nil)
                
            }
        }
    }
    @IBAction func backToToday(_ sender: Any) {
        //this will do? I bet
        let presentIndex = NSIndexPath(item: presentDay, section: 0)
        myTable.scrollToRow(at: presentIndex as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    @objc func bTT(){
        //this will do? I bet
        let presentIndex = NSIndexPath(item: presentDay, section: 0)
        myTable.scrollToRow(at: presentIndex as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        
        print("btt")
    
    }
}


