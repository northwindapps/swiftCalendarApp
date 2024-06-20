//
//  MainViewController.swift
//  googleSchedule
//
//  Created by yujin on 2019/06/20.
//  Copyright © 2019 yujin. All rights reserved.
//

import UIKit
import GoogleMobileAds



var tableContent = [String]()


class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, GADBannerViewDelegate {
    
    //UI,ClassVariables
    @IBOutlet weak var myTable: UITableView!
    var bannerView: GADBannerView!
    
    @IBOutlet weak var homebutton: UIButton!
    
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var thr: UIButton!
    
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var mon: UIButton!
    
    //Variables
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
    
    
    var mainDict = [[String:AnyObject]]()
    var summaries = [String]()
    var text_locationTime = [String]()
    var endDateTime = [String]()
    var endDate = [String]()
    
    var tappedid = 0
    var tappedcol = 0
    //
    var detailboardview :[Detailboardview] = []
    var tableviewHeightAry = [Int]()
    var tableviewHeightSum = 0.0
    
    //
    enum InputType {
        case handwriting
        case keybord
    }
    
    var input_type = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return col0.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if col0[indexPath.row].first == "?"{
            return 30.0
        }else{
            
            let deviceType = UIDevice.current.model
            if deviceType.contains("iPad"){
                return 250.0
            }else{
                return 100.0
            }
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCellLS = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellLS
        
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
        
        cell.M1.textColor = UIColor.blue
        cell.M2.textColor = UIColor.blue
        cell.M3.textColor = UIColor.blue
        cell.M4.textColor = UIColor.blue
        cell.M5.textColor = UIColor.blue
        cell.M6.textColor = UIColor.blue
        cell.M7.textColor = UIColor.blue
        
        cell.M1.font = UIFont.systemFont(ofSize: 11.0)
        cell.M2.font = UIFont.systemFont(ofSize: 11.0)
        cell.M3.font = UIFont.systemFont(ofSize: 11.0)
        cell.M4.font = UIFont.systemFont(ofSize: 11.0)
        cell.M5.font = UIFont.systemFont(ofSize: 11.0)
        cell.M6.font = UIFont.systemFont(ofSize: 11.0)
        cell.M7.font = UIFont.systemFont(ofSize: 11.0)
        
        
        cell.M1.layer.zPosition = 1
        cell.M2.layer.zPosition = 1
        cell.M3.layer.zPosition = 1
        cell.M4.layer.zPosition = 1
        cell.M5.layer.zPosition = 1
        cell.M6.layer.zPosition = 1
        cell.M7.layer.zPosition = 1
        
        cell.M1.layer.borderWidth = 0.5
        cell.M1.layer.borderColor = UIColor.systemGray.cgColor
        cell.M2.layer.borderWidth = 0.5
        cell.M2.layer.borderColor = UIColor.systemGray.cgColor
        cell.M3.layer.borderWidth = 0.5
        cell.M3.layer.borderColor = UIColor.systemGray.cgColor
        cell.M4.layer.borderWidth = 0.5
        cell.M4.layer.borderColor = UIColor.systemGray.cgColor
        cell.M5.layer.borderWidth = 0.5
        cell.M5.layer.borderColor = UIColor.systemGray.cgColor
        cell.M6.layer.borderWidth = 0.5
        cell.M6.layer.borderColor = UIColor.systemGray.cgColor
        cell.M7.layer.borderWidth = 0.5
        cell.M7.layer.borderColor = UIColor.systemGray.cgColor

        
        cell.S1.layer.zPosition = 2
        cell.S2.layer.zPosition = 2
        cell.S3.layer.zPosition = 2
        cell.S4.layer.zPosition = 2
        cell.S5.layer.zPosition = 2
        cell.S6.layer.zPosition = 2
        cell.S7.layer.zPosition = 2

        
        cell.S1.font = UIFont.systemFont(ofSize: 12.0)
        cell.S2.font = UIFont.systemFont(ofSize: 12.0)
        cell.S3.font = UIFont.systemFont(ofSize: 12.0)
        cell.S4.font = UIFont.systemFont(ofSize: 12.0)
        cell.S5.font = UIFont.systemFont(ofSize: 12.0)
        cell.S6.font = UIFont.systemFont(ofSize: 12.0)
        cell.S7.font = UIFont.systemFont(ofSize: 12.0)
        
       
        
        cell.L1.numberOfLines = 0
        cell.L1.lineBreakMode = .byWordWrapping
        
        
        let today = getToday().replacingOccurrences(of: "/0", with: "/")
        cell.S1.text = col0[indexPath.row]
        cell.S2.text = col1[indexPath.row]
        cell.S3.text = col2[indexPath.row]
        cell.S4.text = col3[indexPath.row]
        cell.S5.text = col4[indexPath.row]
        cell.S6.text = col5[indexPath.row]
        cell.S7.text = col6[indexPath.row]
        
        
        
        if ym0[indexPath.row] == today{
            cell.S1.backgroundColor = UIColor.clear
            cell.S1.textColor = UIColor.red
            cell.S1.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M1.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S1.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M1.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S1.backgroundColor = UIColor.clear
            cell.S1.textColor = UIColor.red
            cell.S1.layer.cornerRadius = 0.0
            cell.M1.layer.cornerRadius = 0.0
            cell.M1.backgroundColor = UIColor.white
            
        }
        
        if ym1[indexPath.row] == today{
            cell.S2.backgroundColor = UIColor.clear
            cell.S2.textColor = UIColor.black
            cell.S2.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M2.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S2.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M2.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S2.backgroundColor = UIColor.clear
            cell.S2.textColor = UIColor.black
            cell.S2.layer.cornerRadius = 0.0
            cell.M2.layer.cornerRadius = 0.0
            cell.M2.backgroundColor = UIColor.white
            
        }
        
        if ym2[indexPath.row] == today{
            cell.S3.backgroundColor = UIColor.clear
            cell.S3.textColor = UIColor.black
            cell.S3.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M3.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S3.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M3.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S3.backgroundColor = UIColor.clear
            cell.S3.textColor = UIColor.black
            cell.S3.layer.cornerRadius = 0.0
            cell.M3.layer.cornerRadius = 0.0
            cell.M3.backgroundColor = UIColor.white
            
        }
        
        if ym3[indexPath.row] == today{
            cell.S4.backgroundColor = UIColor.clear
            cell.S4.textColor = UIColor.black
            cell.S4.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M4.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S4.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M4.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S4.backgroundColor = UIColor.clear
            cell.S4.textColor = UIColor.black
            cell.S4.layer.cornerRadius = 0.0
            cell.M4.layer.cornerRadius = 0.0
            cell.M4.backgroundColor = UIColor.white
            
        }
        
        if ym4[indexPath.row] == today{
            cell.S5.backgroundColor = UIColor.clear
            cell.S5.textColor = UIColor.black
            cell.S5.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M5.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S5.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M5.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S5.backgroundColor = UIColor.clear
            cell.S5.textColor = UIColor.black
            cell.S5.layer.cornerRadius = 0.0
            cell.M5.layer.cornerRadius = 0.0
            cell.M5.backgroundColor = UIColor.white
            
        }
        
        if ym5[indexPath.row] == today{
            cell.S6.backgroundColor = UIColor.clear
            cell.S6.textColor = UIColor.black
            cell.S6.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M6.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S6.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M6.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S6.backgroundColor = UIColor.clear
            cell.S6.textColor = UIColor.black
            cell.S6.layer.cornerRadius = 0.0
            cell.M6.layer.cornerRadius = 0.0
            cell.M6.backgroundColor = UIColor.white
            
        }
        
        if ym6[indexPath.row] == today{
            cell.S7.backgroundColor = UIColor.clear
            cell.S7.textColor = UIColor.black
            cell.S7.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.M7.backgroundColor = UIColor(red: 129/255, green: 206/255, blue: 255/255, alpha: 1.0)
            cell.S7.roundCorners(corners: [.topLeft,.topRight], radius: 5)
            cell.M7.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 5)
            
            
        }else {
            cell.S7.backgroundColor = UIColor.clear
            cell.S7.textColor = UIColor.black
            cell.S7.layer.cornerRadius = 0.0
            cell.M7.layer.cornerRadius = 0.0
            cell.M7.backgroundColor = UIColor.white
            
        }
        
        
        
        if col0[indexPath.row].first == "?"{
            
            cell.L1.text = col0[indexPath.row].replacingOccurrences(of: "?", with: "")
            print(col0[indexPath.row])
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
            
            cell.M1.layer.zPosition = 0
            cell.M2.layer.zPosition = 0
            cell.M3.layer.zPosition = 0
            cell.M4.layer.zPosition = 0
            cell.M5.layer.zPosition = 0
            cell.M6.layer.zPosition = 0
            cell.M7.layer.zPosition = 0
            cell.L1.layer.zPosition = 1
            cell.L1.textColor = UIColor.black

            cell.M1.layer.borderWidth = 0.0
            cell.M1.layer.borderColor = UIColor.systemGray.cgColor
            cell.M2.layer.borderWidth = 0.0
            cell.M2.layer.borderColor = UIColor.systemGray.cgColor
            cell.M3.layer.borderWidth = 0.0
            cell.M3.layer.borderColor = UIColor.systemGray.cgColor
            cell.M4.layer.borderWidth = 0.0
            cell.M4.layer.borderColor = UIColor.systemGray.cgColor
            cell.M5.layer.borderWidth = 0.0
            cell.M5.layer.borderColor = UIColor.systemGray.cgColor
            cell.M6.layer.borderWidth = 0.0
            cell.M6.layer.borderColor = UIColor.systemGray.cgColor
            cell.M7.layer.borderWidth = 0.0
            cell.M7.layer.borderColor = UIColor.systemGray.cgColor
            
            cell.clipsToBounds = false
            cell.layer.shadowOpacity=0.7
            cell.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.layer.backgroundColor = UIColor.systemBlue.cgColor
            
           
        }else{
            cell.L1.text = ""
            cell.L1.layer.zPosition = 0
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.layer.shadowOpacity=0.0
            cell.layer.backgroundColor = UIColor.clear.cgColor
        }
        
        
        
        
        
        
        //Main Content
        if text_location.contains(ym0[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym0[indexPath.row])
            cell.M1.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym0[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym0[indexPath.row])
            cell.M1.text = text_content[indexOfA!]
        }else{
            cell.M1.text = ""
        }
        
        if text_location.contains(ym1[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym1[indexPath.row])
            cell.M2.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym1[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym1[indexPath.row])
            cell.M2.text = text_content[indexOfA!]
        }else{
            cell.M2.text = ""
        }
        
        if text_location.contains(ym2[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym2[indexPath.row])
            cell.M3.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym2[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym2[indexPath.row])
            cell.M3.text = text_content[indexOfA!]
        }else{
            cell.M3.text = ""
        }
        
        if text_location.contains(ym3[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym3[indexPath.row])
            cell.M4.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym3[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym3[indexPath.row])
            cell.M4.text = text_content[indexOfA!]
        }else{
            cell.M4.text = ""
        }
        
        if text_location.contains(ym4[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym4[indexPath.row])
            cell.M5.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym4[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym4[indexPath.row])
            cell.M5.text = text_content[indexOfA!]
        }else{
            cell.M5.text = ""
        }
        
        if text_location.contains(ym5[indexPath.row])  {
            
            let indexOfA = text_location.firstIndex(of: ym5[indexPath.row])
            cell.M6.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym5[indexPath.row])  {
            
            let indexOfA = text_locationTime.firstIndex(of: ym5[indexPath.row])
            cell.M6.text = text_content[indexOfA!]
        }else{
            cell.M6.text = ""
        }
        
        if text_location.contains(ym6[indexPath.row])  {
            let indexOfA = text_location.firstIndex(of: ym6[indexPath.row])
            cell.M7.text = text_content[indexOfA!]
        }else if text_locationTime.contains(ym6[indexPath.row])  {
            let indexOfA = text_locationTime.firstIndex(of: ym6[indexPath.row])
            cell.M7.text = text_content[indexOfA!]
        }else{
            cell.M7.text = ""
        }
        
        tableviewHeightSum += Double(cell.bounds.height)
        tableviewHeightAry.append(Int(tableviewHeightSum))
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate = self
        myTable.dataSource = self
        
        
        //bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        //bannerView.delegate = self
        //addBannerViewToView(bannerView)
        //bannerView.adUnitID = "ca-app-pub-5284441033171047/2532822513"
        //"ca-app-pub-3940256099942544/2934735716"
        //ca-app-pub-5284441033171047/4975207581
        
        //        bannerView.rootViewController = self
        //                bannerView.load(GADRequest())
        
        
        
        
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
        
        homebutton.addTarget(self, action: #selector(scrollToRow), for: UIControl.Event.touchUpInside)
        //
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MainViewController.scrollToRow), userInfo: nil, repeats: false)
        
        
        
    }
    
    
    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//        ])
//    }
    
    
    
    @objc func formatGoogleDate(googleDate:String)->String{
        
        var doneDateStr = ""
        if googleDate.count > 0{
            let replaceSlash = googleDate.replacingOccurrences(of: "-0", with: "-")
            doneDateStr = (replaceSlash.replacingOccurrences(of: "-", with: "/"))
        }
        return doneDateStr
    }
    
    @objc func formatGoogleDateTime(googleDate:String)->String{
        
        var doneDateStr = ""
        if googleDate.count > 0{
            let takeoutT = googleDate.split(separator: "T").first
            let replaceSlash = takeoutT?.replacingOccurrences(of: "-0", with: "-")
            doneDateStr = (replaceSlash?.replacingOccurrences(of: "-", with: "/"))!
        }
        return doneDateStr
    }
    
    @objc func bTT(){
        //this will do? I bet
        let presentIndex = NSIndexPath(item: presentDay, section: 0)
        myTable.scrollToRow(at: presentIndex as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
        
        print("btt")
        
    }
    
    func screenshot() -> UIImage{
    var image = UIImage();
        UIGraphicsBeginImageContextWithOptions(myTable.contentSize, false, UIScreen.main.scale)

        // save initial values
        let savedContentOffset = myTable.contentOffset;
        let savedFrame = myTable.frame;
        let savedBackgroundColor = myTable.backgroundColor

        // reset offset to top left point
        myTable.contentOffset = CGPoint(x: 0, y: 0);
        // set frame to content size
        myTable.frame = CGRect(x: 0, y: 0, width: myTable.contentSize.width, height: myTable.contentSize.height);
        // remove background
        myTable.backgroundColor = UIColor.clear

        // make temp view with scroll view content size
        // a workaround for issue when image on ipad was drawn incorrectly
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: myTable.contentSize.width, height: myTable.contentSize.height));

        // save superview
        let tempSuperView = myTable.superview
        // remove scrollView from old superview
        myTable.removeFromSuperview()
        // and add to tempView
        tempView.addSubview(myTable)

        // render view
        // drawViewHierarchyInRect not working correctly
        tempView.layer.render(in: UIGraphicsGetCurrentContext()!)
        // and get image
        image = UIGraphicsGetImageFromCurrentImageContext()!;

        // and return everything back
        tempView.subviews[0].removeFromSuperview()
        tempSuperView?.addSubview(myTable)

        // restore saved settings
        myTable.contentOffset = savedContentOffset;
        myTable.frame = savedFrame;
        myTable.backgroundColor = savedBackgroundColor

        UIGraphicsEndImageContext();

        return image
    }
    
    @objc func tappedcell(_ sender : UITapGestureRecognizer ){
        let p = sender.location(in: sender.view)
        let indexPath = myTable .indexPathForRow(at: p)
        myTable.deselectRow(at: indexPath!, animated: false)
        tappedid = indexPath!.row
        
        let cell = myTable.cellForRow(at: indexPath!) as! TableViewCellLS
        let pointInCell = sender.location(in: cell) as CGPoint
        
        // get a screenshot of just this view
//        let snapshot = screenshot()

        // save photo
//        UIImageWriteToSavedPhotosAlbum(snapshot, nil, nil, nil)
        
        if cell.M1.frame.contains(pointInCell){
            //switch handwriting or text
            tappedcol = 0
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym0)
        }
        
        if cell.M2.frame.contains(pointInCell){
            tappedcol = 1
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym1)
        }
        
        if cell.M3.frame.contains(pointInCell){
            tappedcol = 2
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym2)
        }
        
        if cell.M4.frame.contains(pointInCell){
            tappedcol = 3
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym3)
        }
        
        if cell.M5.frame.contains(pointInCell){
            tappedcol = 4
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym4)
        }
        
        if cell.M6.frame.contains(pointInCell){
            tappedcol = 5
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym5)
        }
        
        if cell.M7.frame.contains(pointInCell){
            tappedcol = 6
            handleInputType(inputType: 1,IP: indexPath!,pointInCell: pointInCell,ym: ym6)
        }
    }
    
    @objc func terminate(sender:UIButton){
        print(sender.tag)
        for i in 0..<detailboardview.count{
            if detailboardview[i].tag == sender.tag{
                detailboardview[i].removeFromSuperview()
            }
        }
        
    }
    
    @objc func noteBgcolor(dateStr:String)->UIColor{
        let middle = dateStr.components(separatedBy: "/")
        
        
        
        if middle.count > 1{
            switch middle[1] {
            case "0":
                return UIColor.systemBlue
            case "1":
                return UIColor.systemYellow
            case "2":
                return UIColor.lightGray
            case "3":
                return UIColor.init(red: 200/255, green: 255/255, blue: 191/255, alpha: 1.0)
            case "4":
                
                return UIColor.systemGreen
            case "5":
                return UIColor.cyan
            case "6":
                return UIColor.init(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
            case "7":
                return UIColor.init(red: 227/255, green: 255/255, blue: 107/255, alpha: 1.0)
            case "8":
                return UIColor.systemRed
                
            case "9":
                return UIColor.systemOrange
            case "10":
                return UIColor.init(red: 193/255, green: 178/255, blue: 153/255, alpha: 1.0)
            case "11":
                return UIColor.init(red: 63/255, green: 169/255, blue: 245/255, alpha: 1.0)
            case "12":
                return UIColor.init(red: 179/255, green: 179/255, blue: 179/255, alpha: 1.0)
            default:
                return UIColor.lightGray
            }
        }else{
            return UIColor.lightGray
        }
    }
    
    @objc func saveedit1(sender:UIButton){
        let ym = [ym0,ym1,ym2,ym3,ym4,ym5,ym6]
        let id = self.tappedid
        let receivedstr = ym[self.tappedcol][id] as String
        if receivedstr.contains("//"){return}
        for i in 0..<detailboardview.count{
            if detailboardview[i].tag == sender.tag{
                let body = detailboardview[i].myTextView.text as String
                save_text_action(receivedstr: receivedstr, bodytext: body)
                detailboardview[i].myTextView.resignFirstResponder()
            }
        }
        terminate(sender: sender)
    }
    
    @objc func moveedit1(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym0[id]) != nil {
            resultViewController.receivedstr = ym0[id]
            let ArrayyyyMMDD = ym0[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit2(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym1[id]) != nil {
            resultViewController.receivedstr = ym1[id]
            let ArrayyyyMMDD = ym1[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit3(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym2[id]) != nil {
            resultViewController.receivedstr = ym2[id]
            let ArrayyyyMMDD = ym2[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit4(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym3[id]) != nil {
            resultViewController.receivedstr = ym3[id]
            let ArrayyyyMMDD = ym3[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit5(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym4[id]) != nil {
            resultViewController.receivedstr = ym4[id]
            let ArrayyyyMMDD = ym4[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit6(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym5[id]) != nil {
            resultViewController.receivedstr = ym5[id]
            let ArrayyyyMMDD = ym5[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func moveedit7(){
        let id = self.tappedid
        // Destination
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Eview") as! EditViewController
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy/MM/dd"
        if dateFormatterGet.date(from: ym6[id]) != nil {
            resultViewController.receivedstr = ym6[id]
            let ArrayyyyMMDD = ym6[id].components(separatedBy: "/")
            resultViewController.receivedyear = Int(ArrayyyyMMDD[0])
            
            //https://stackoverflow.com/questions/49472570/in-swift-can-you-split-a-string-by-another-string-not-just-a-character
            
            
            resultViewController.returnMM = Int(ArrayyyyMMDD[1])//2019/11 break into 2019 11
            resultViewController.returnDD = Int(ArrayyyyMMDD[2])
            
            resultViewController.table_type = 0
            resultViewController.useryear = Int(ArrayyyyMMDD[0])!
            resultViewController.indexofTable = (id)
            resultViewController.daysArray = DDArray
            resultViewController.monthsArray = MMArray
            resultViewController.text_content = text_content
            resultViewController.text_location = text_location
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
    
    @objc func getToday()->String{
        //get the current year. user get the current year whenever they live
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
        
    }
    
    @objc func scrollToRow(){
        let idx = IndexPath(row: findTodaysRow(), section: 0)
        myTable.scrollToRow(at: idx, at: .middle, animated: true)
    }
    
    func findTodaysRow()->Int{
        let todayStr = getToday().replacingOccurrences(of: "/0", with: "/")
        print("todayStr",todayStr)
        for i in 0..<ym0.count{
            if ym0[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym1.count{
            if ym1[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym2.count{
            if ym2[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym3.count{
            if ym3[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym4.count{
            if ym4[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym5.count{
            if ym5[i] == todayStr{
                return i
            }
        }
        
        for i in 0..<ym6.count{
            if ym6[i] == todayStr{
                return i
            }
        }
        
        return 5
    }
    
    func set_button_title() -> String {
        //localization
        if let preferredLanguage = NSLocale.preferredLanguages[0] as String? {
            
            if preferredLanguage.contains("fr"){
                return "enregistrer"
            }
            
            if preferredLanguage.contains("en"){
                return "save"
                
            }
            
            if preferredLanguage.contains("ja"){
                return "保存"
            }
            
            if preferredLanguage.contains("de"){
                return "speichern"
            }
            
            if preferredLanguage.contains("it"){
                return "salvare"
            }
            
            if preferredLanguage.contains("zh-Hans"){
                return "保存"
            }
            
            if preferredLanguage.contains("es"){
                return "guardar"
            }
            return "save"
        }
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //       let delta =  scrollView.contentOffset.y
    //
    //        print("delta",delta)
    //
    //        for i in 0..<detailboardview.count{
    //
    //            let original = detailboardview[i].center
    ////            detailboardview[i].center = CGPoint(x: original.x, y: 0.0 - delta)
    //            print(original)
    //        }
    //
    //    }
    
    func save_text_action(receivedstr:String,bodytext:String) {
        print("receivedstr",receivedstr)
        if text_location.contains(receivedstr){
            
            let whereitexists = text_location.index(of: receivedstr)
            text_content[whereitexists!] = bodytext
        
            
        }else{
            
            if bodytext.count > 0 {
            text_location.append(receivedstr)
            text_content.append(bodytext)
         
            
            }
        }
  
        let dict = Dictionary(uniqueKeysWithValues: zip(text_location,text_content))//2020/04/08/12 : Went to sea
        let export = Export()
        let jsoned = export.jsonExport(source: dict)
        if JSONSerialization.isValidJSONObject(jsoned) {
            //print(jsoned) OK!
        }
        
        let temp = Export()
        temp.saveJsonFile(source: jsoned as! Dictionary<String, String>)
        // Done
        
        myTable.reloadData()
    }

    func handleInputType(inputType: Int, IP:IndexPath, pointInCell:CGPoint,ym:[String]) {
        // Convert integer inputType to the appropriate InputType enum value and handle each case directly
        switch inputType {
        case 0:
            // Handle handwriting input
            print("Handling handwriting input")
            // Add further logic for handwriting input here
            
        case 1:
            // Handle text input
            print("Handling text input")
            // Add further logic for text input here
            let id = ym[IP.row].replacingOccurrences(of: "/", with: "")
            for i in 0..<detailboardview.count{
                if detailboardview[i].tag == Int(id)!{
                    detailboardview[i].removeFromSuperview()
                }
            }
            
            var item1 = (Detailboardview(frame: CGRect(x:Int(pointInCell.x),y:Int(myTable.contentOffset.y), width: 300,height: 250)))
            
            item1.tag = IP.row
            item1.closeButton.tag = Int(id)!
            item1.edit.tag = Int(id)! //indexPath!.row
            item1.edit.setTitle(set_button_title(), for: .normal)
            item1.closeButton.addTarget(self, action: #selector(terminate), for: UIControl.Event.touchUpInside)
            
            item1.edit.addTarget(self, action: #selector(saveedit1), for: UIControl.Event.touchUpInside)
            
            var summary = "type something.."
            for i in 0..<text_location.count{
                if text_location[i] == ym[IP.row]{
                    summary = ""
                    summary.append(text_content[i])
                    summary.append("\n")
                }
            }
            
            item1.myTextView.text  = summary
            item1.dateLabel.text = ym[IP.row]
//            item1.view.backgroundColor = noteBgcolor(dateStr: ym0[indexPath!.row])
            item1.tag = Int(id)!
            myTable.addSubview(item1)
            detailboardview.append(item1)
            item1.lastLocation = CGPoint(x:10,y:Int(myTable.contentOffset.y))
            
            item1.clipsToBounds = false
            item1.view.layer.shadowOpacity=0.7
            item1.view.layer.shadowOffset = CGSize(width: 1, height: 1)
//            item1.myTextView.becomeFirstResponder()
            
        default:
            // Handle default case, assuming handwriting as default
            print("Handling default case (assumed handwriting)")
            // Add further logic for default case here
        }
    }
    
    @IBAction func listViewSequeAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Dview") as! DataViewController
        self.present(resultViewController, animated:true, completion:nil)
    }
}
extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}
public extension UIView {
    /**
        Captures view and subviews in an image
    */
    func snapshotViewHierarchy() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return copied
    }
}
