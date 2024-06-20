//
//  MailViewController.swift
//  
//
//  Created by yujin on 2019/12/16.
//

import UIKit
import MessageUI

class MailViewController: UIViewController,MFMailComposeViewControllerDelegate  {

    var text_content = [String]()
    var text_location = [String]()
    
    override func viewDidLoad() {
        
        let AppDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        AppDel.returnstr = -1
        
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
    
    @IBAction func sendingMail(_ sender: Any) {
        
        
        //Move to MailView
        if MFMailComposeViewController.canSendMail() {
            let today: Date = Date()
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let date = dateFormatter.string(from: today)
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            //
            let initial = Export()
            (text_location,text_content) = initial.readJsonFIle()
            
            let fullStack = Dictionary(uniqueKeysWithValues: zip(text_location,text_content))
            
            let export = Export()
            let jsoned = export.jsonExport(source: fullStack)
            
            
            if JSONSerialization.isValidJSONObject(jsoned) {
                //print(jsoned) OK!
                
            }
            
            // Great: https://dev.classmethod.jp/smartphone/swift3-json/
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: jsoned, options: [])
                //let jsonStr = String(bytes: jsonData, encoding: .utf8)!
                
                // Attaching the .CSV file to the email.
                mail.addAttachmentData(jsonData, mimeType: "application/json", fileName: date)
                
                present(mail, animated: true)
            } catch let error {
                print(error)
            }
            
            
            
        } else {
            // show failure alert
        }
        
    }
    
    
    @IBAction func `return`(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Dview") as! DataViewController
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    //http://stackoverflow.com/questions/35782218/swift-how-to-make-mfmailcomposeviewcontroller-disappear
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
