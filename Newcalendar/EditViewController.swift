//
//  EditViewController.swift
//  calendarchart
//
//  Created by 矢野悠人 on 2017/08/21.
//  Copyright © 2017年 yumiya. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation
import AppTrackingTransparency
import AdSupport

class EditViewController: UIViewController,UITextViewDelegate,GADBannerViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate {
    
    @IBOutlet weak var imagewindow: UIImageView!
    
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var Playbutton: UIButton!
    
    @IBOutlet weak var bannerview: GADBannerView!
    
    
    @IBOutlet weak var nextbutton: UIButton!
    @IBOutlet weak var previousbutton: UIButton!
    
    var table_type = 0
    var receivedstr :String!
    var receivedyear :Int!
    var returnMM  :Int!
    var returnDD  :Int!
    var useryear :Int = 0
    var indexofTable: Int = 0
    var daysArray = [String]()
    var monthsArray = [String]()
    
    var text_content = [String]()
    var text_location = [String]()
 
    
    var musicSound: AVAudioPlayer?
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var entryview: UITextView!
    
    func save_text_action() {
        print("receivedstr",receivedstr)
        if receivedstr.contains("//"){return}
        if text_location.contains(receivedstr){
            
            let whereitexists = text_location.index(of: receivedstr)
            text_content[whereitexists!] = entryview.text
        
            
        }else{
            
            if entryview.text.count > 0 {
            text_location.append(receivedstr)
            text_content.append(entryview.text)
         
            
            }
        }
        
//        let defaults0 = UserDefaults.standard
//        defaults0.set(text_location , forKey: "textlocation")
//        defaults0.synchronize()
//
//        let defaults1 = UserDefaults.standard
//        defaults1.set(text_content , forKey: "textcontent")
//        defaults1.synchronize()
  
        let dict = Dictionary(uniqueKeysWithValues: zip(text_location,text_content))//2020/04/08/12 : Went to sea
        let export = Export()
        let jsoned = export.jsonExport(source: dict)
        if JSONSerialization.isValidJSONObject(jsoned) {
            //print(jsoned) OK!
        }
        
        let temp = Export()
        temp.saveJsonFile(source: jsoned as! Dictionary<String, String>)
        // Done
    }
    
    
    
    @IBAction func Return(_ sender: Any) {
        
        //https://stackoverflow.com/questions/25375409/how-to-switch-view-controllers-in-swift
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Dview") as! DataViewController
        
        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
     
//        AppDel.scrollposition = indexofTable
        AppDel.returnstr = receivedyear
        AppDel.eviewdate = titlelabel.text!
        AppDel.returnMM = returnMM
        AppDel.returnDD = returnDD
    
        
        save_text_action()
        
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    override func viewDidLoad() {
        
        
   
        
        self.titlelabel.text = receivedstr
        
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someaction (_:)))
        
        self.view.addGestureRecognizer(gesture)
        
        entryview.delegate = self
        
        
        
        //
        if text_location.contains(receivedstr) {
            
            let whereitexsits = text_location.index(of: receivedstr)
            
            self.entryview.text = text_content[whereitexsits!]
        }else{
            
            
        }
        
        //
        let keystring = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Image"
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let imageURL = docDir.appendingPathComponent(keystring)
            
        if UIImage(contentsOfFile: imageURL.path) != nil{
                
            imagewindow.image = UIImage(contentsOfFile: imageURL.path)!
                
        }else{}
       
        
        
        
        //http://stackoverflow.com/questions/27551291/uitableview-backgroundcolor-always-white-on-ipad
        
        //"ca-app-pub-5284441033171047/3376639207"
        
        
        
        bannerview.isHidden = true
        bannerview.delegate = self
        bannerview.adUnitID = "ca-app-pub-5284441033171047/2532822513"
        bannerview.rootViewController = self
        
        
        bannerview.layer.borderWidth = 1
        bannerview.layer.borderColor = UIColor.blue.cgColor
        requestIDFA()
        
        check_if_thefile_exsits()
        
        switch table_type {
        case 0:
            nextbutton.isHidden = false
            previousbutton.isHidden = false
            break
        case 1:
            nextbutton.isHidden = true
            previousbutton.isHidden = true
            break
        default:
            break
        }
        
        //Get index
        for i in 0..<daysArray.count{
            let current = String(useryear) + "/" + String(monthsArray[i]) + "/" + String(daysArray[i])
            if receivedstr == current{
                indexofTable = i
            }
        }
        
        entryview.becomeFirstResponder()
    }
    
    func requestIDFA() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                // Tracking authorization completed. Start loading ads here.
                // loadAd()
                self.bannerview.load(GADRequest())
            })
        } else {
            // Fallback on earlier versions
            self.bannerview.load(GADRequest())
        }
    }
 
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerview.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerview.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hides text views
    
    @objc func someaction(_ sender:UITapGestureRecognizer){
        entryview.resignFirstResponder()
        
        
    }
  
    @IBAction func nextday(_ sender: Any) {
        
            save_text_action()
        
            indexofTable += 1
        
        
        
            if indexofTable > monthsArray.count-1{
                indexofTable = monthsArray.count-1
            }
        
        
            receivedstr = String(useryear) + "/" + monthsArray[indexofTable] + "/" + daysArray[indexofTable]
            titlelabel.text = receivedstr
        
            if Int(monthsArray[indexofTable]) != nil{
                returnMM = Int(monthsArray[indexofTable])!
            }
        
            if Int(daysArray[indexofTable]) != nil{
                returnDD = Int(daysArray[indexofTable])!
            }
        
            
            if text_location.contains(receivedstr) {
                
                let whereitexsits = text_location.index(of: receivedstr)
                
                self.entryview.text = text_content[whereitexsits!]
            }else{
                
                self.entryview.text = ""
                
            }
            
            
            //
            //
            let keystring = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Image"
            
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
        
                
            let imageURL = docDir.appendingPathComponent(keystring)
                
            if UIImage(contentsOfFile: imageURL.path) != nil{
                    
                    imagewindow.image = UIImage(contentsOfFile: imageURL.path)!
                    
            }else{ imagewindow.image = nil }
        
        
            check_if_thefile_exsits()
      
        
    }
    @IBAction func previousday(_ sender: Any) {
        
            save_text_action()
        
            indexofTable -= 1
        
        
            if indexofTable < 0{
                indexofTable = 0
            }
        
        
            receivedstr = String(useryear) + "/" + monthsArray[indexofTable] + "/" + daysArray[indexofTable]
            titlelabel.text = receivedstr
        
            if Int(monthsArray[indexofTable]) != nil{
                returnMM = Int(monthsArray[indexofTable])!
            }
        
            if Int(daysArray[indexofTable]) != nil{
                returnDD = Int(daysArray[indexofTable])!
            }
        
            if text_location.contains(receivedstr) {
            
                let whereitexsits = text_location.index(of: receivedstr)
            
                self.entryview.text = text_content[whereitexsits!]
            }else{
            
                self.entryview.text = ""
            
            }
            
            
            //
            //
            let keystring = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Image"
            
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
        
                
            let imageURL = docDir.appendingPathComponent(keystring)
                
            if UIImage(contentsOfFile: imageURL.path) != nil{
                    
                imagewindow.image = UIImage(contentsOfFile: imageURL.path)!
                    
            }else{ imagewindow.image = nil }
       
        
            check_if_thefile_exsits()
      
    }
    @IBAction func Imageaction(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            
            imagewindow.image = image
            
            
            
            
            let keystring = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Image"
            //print(keystring)
            
            let imageData = image.pngData()!
            let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            
            let imageURL = docDir.appendingPathComponent(keystring)
            try! imageData.write(to: imageURL)
            
            
        }else{
            
            
            
        }
        
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func VoicerecordAction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Aview") as! AudioViewController
        
        
        resultViewController.receivedstr = receivedstr
        
        
        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        AppDel.scrollposition = indexofTable
        AppDel.stringcache = entryview.text
        AppDel.returnstr = receivedyear
        AppDel.returnMM = returnMM
        AppDel.returnDD = returnDD
        
        save_text_action()
       
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    func check_if_thefile_exsits(){
        //https://stackoverflow.com/questions/24181699/how-to-check-if-a-file-exists-in-the-documents-directory-in-swift
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: path)
        let filename = receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a"
        
        let filePath = url.appendingPathComponent(filename).path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            //print("FILE AVAILABLE")
            Playbutton.isHidden = false
        } else {
            //print("FILE NOT AVAILABLE")
            Playbutton.isHidden = true
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    @IBAction func StartPlayback(_ sender: Any) {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent(receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a")
        
        let url = audioFilename
        
        do {
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        } catch {
            //couldn't load file :(
        }
    }
    
}
