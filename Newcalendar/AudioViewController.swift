//
//  AudioViewController.swift
//  Newcalendar
//
//  Created by yujinyano on 2018/07/23.
//  Copyright © 2018年 yujinyano. All rights reserved.
//

import UIKit
import AVFoundation
//import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class AudioViewController: UIViewController,UITextViewDelegate,AVAudioRecorderDelegate {
    
//    @IBOutlet weak var bannerview: GADBannerView!
    
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet weak var stopbutton: UIButton!
    
    
    @IBOutlet weak var deletebutton: UIButton!
    
    //Recording
    @IBOutlet weak var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    //
    var musicSound: AVAudioPlayer?
    var receivedstr = ""
    var recordstr = "Record"
    var playstr = "Play"
    var stopstr = "Stop"
    var delstr = "Delete"
    
    var newmessage = "Record new message ?"
    var delmessage = "Delete this file ?"
    var yesstr = "yes"
    var nostr = "no"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        bannerview.isHidden = true
//        bannerview.delegate = self
//        bannerview.adUnitID = "ca-app-pub-5284441033171047/3376639207"//"ca-app-pub-5284441033171047/3376639207"
//        bannerview.rootViewController = self
//        requestIDFA()
//        
//        bannerview.layer.borderWidth = 1
//        bannerview.layer.borderColor = UIColor.blue.cgColor
        
        //Recording
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSession.Category.playAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        
        
        //localization
        if let preferredLanguage = NSLocale.preferredLanguages[0] as String? {
            
            
            
            if preferredLanguage.contains("fr"){
                
                recordstr = "Commencer l'enregistrement"
                stopstr = "Arrête d'enregistrer"
                playstr = "Lire le fichier"
                delstr = "Supprimer le fichier"
                
                
                newmessage = "Enregistrer un nouveau message?"
                delmessage = "Supprimer ce message?"
                
                yesstr = "Oui"
                nostr = "Non"
                
            }
            
            if preferredLanguage.contains("ja"){
                
                recordstr = "録音を開始"
                stopstr = "録音を停止する"
                playstr = "再生する"
                delstr = "削除する"
                newmessage = "新しいメッセージ?"
                delmessage = "削除しますか？"
               
                yesstr = "はい"
                nostr = "いいえ"
                
                
            }
            
            if preferredLanguage.contains("ja"){
                
                recordstr = "録音を開始"
                stopstr = "録音を停止する"
                playstr = "再生する"
                delstr = "削除する"
                newmessage = "新しいメッセージ?"
                delmessage = "削除しますか？"
               
                yesstr = "はい"
                nostr = "いいえ"
                
                
            }
            
            if preferredLanguage.contains("es"){
                
                recordstr = "grabación de voz"
                stopstr = "para de grabar"
                playstr = "reproducción"
                delstr = "bórralo"
                newmessage = "nuevo mensaje?"
                delmessage = "¿bórralo?"
               
                yesstr = "si"
                nostr = "no"
                
                
            }
            
            if preferredLanguage.contains("de"){
                
                recordstr = "Starte die Aufnahme"
                stopstr = "Höre auf, aufzunehmen"
                playstr = "Datei abspielen"
                delstr = "Löschen Sie die Datei"
                
                newmessage = "Neue Nachricht aufzeichnen?"
                delmessage = "Löschen Sie diese Nachricht?"
                
                yesstr = "Sì"
                nostr = "No"
                
                
            }
            
            if preferredLanguage.contains("it"){
              
                recordstr = "Inizia a registrare"
                stopstr = "Interrompe la registrazione"
                playstr = "Riprodurre il file"
                delstr = "Elimina il file"
                
                newmessage = "Registra un nuovo messaggio?"
                delmessage = "Cancella questo messaggio?"
                
                yesstr = "Ja"
                nostr = "Nein"
                
            }
            
            if preferredLanguage.contains("zh-Hans"){
                
                recordstr = "开始录制"
                stopstr = "停止录音"
                playstr = "播放数据"
                delstr = "删除文件"
                
                newmessage = "记录新消息？"
                delmessage = "删除此消息？"
                
                yesstr = "是"
                nostr = "不是"
                
            }
        }
        
        recordButton.setTitle(recordstr, for: .normal)
        stopbutton.setTitle(stopstr, for: .normal)
        playbutton.setTitle(playstr, for: .normal)
        deletebutton.setTitle(delstr, for: .normal)
        
    }
    
//    func requestIDFA() {
//        if #available(iOS 14, *) {
//            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
//                // Tracking authorization completed. Start loading ads here.
//                // loadAd()
//                self.bannerview.load(GADRequest())
//            })
//        } else {
//            // Fallback on earlier versions
//            self.bannerview.load(GADRequest())
//        }
//    }
//    
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        bannerview.isHidden = false
//    }
//    
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        bannerview.isHidden = true
//    }
//    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //recording section
    func loadRecordingUI() {
        
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent(receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Stop     ", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func clearTempFolder() {
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent(receivedstr.replacingOccurrences(of: "/", with: "slash") + "Audio" + ".m4a")
        
        
        let fileManager = FileManager.default
        
        do {
            
            try fileManager.removeItem(at: audioFilename)
            
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Re-record    ", for: .normal)
        } else {
            recordButton.setTitle("Record     ", for: .normal)
            // recording failed :(
        }
    }
    
    @objc func recordTapped2() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
    
    
    @objc func recordTapped() {
        
        
        if self.audioRecorder == nil {
            
            
            
            //http://qiita.com/fishpilot272/items/b76e62eb82fc8d788da5
            // ① UIAlertControllerクラスのインスタンスを生成
            // タイトル, メッセージ, Alertのスタイルを指定する
            // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
            
            let caution = "CAUTION"
            
            let message = newmessage
            
            let alert: UIAlertController = UIAlertController(title: caution, message: message, preferredStyle:  UIAlertController.Style.alert)
            
            let ok = yesstr
            
            
            
            let defaultAction: UIAlertAction = UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler:{
                
                (action: UIAlertAction!) -> Void in
                //http://yuichi-dev.blogspot.jp/2015/04/swiftnsuserdefaults.html
                // 保存メッセージを削除
                self.self.startRecording()
                
                
            })
            
            
            
            let ok2 = nostr
            
            
            
            
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
            
            
        } else {
            self.finishRecording(success: true)
        }
        
    }
    
    
    
    
    
    
    
    
    
    //player
    @IBAction func playMusic(_ sender: Any) {
        
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
    
    @IBAction func stopMusic(_ sender: Any) {
        musicSound?.stop()
    }
    
    @IBAction func Return(_ sender: Any) {
        
        //https://stackoverflow.com/questions/25375409/how-to-switch-view-controllers-in-swift
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Dview") as! DataViewController
        
        
        
        
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        
        let caution = "CAUTION"
        
        let message = delmessage
        
        let alert: UIAlertController = UIAlertController(title: caution, message: message, preferredStyle:  UIAlertController.Style.alert)
        
        let ok = yesstr
        
        
        
        let defaultAction: UIAlertAction = UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler:{
            
            (action: UIAlertAction!) -> Void in
            //http://yuichi-dev.blogspot.jp/2015/04/swiftnsuserdefaults.html
            
            self.clearTempFolder()
            
            
        })
        
        
        
        let ok2 = nostr
        
        
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: ok2, style: UIAlertAction.Style.cancel, handler:{
            
            (action: UIAlertAction!) -> Void in
            
        })
        
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        
        present(alert, animated: true, completion: nil)
        
    }
}
