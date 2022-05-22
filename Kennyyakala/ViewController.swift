//
//  ViewController.swift
//  Kennyyakala
//
//  Created by Fatih Filizol on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblHighscore: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    
    @IBOutlet weak var bro10: UIImageView!
    @IBOutlet weak var bro18: UIImageView!
    @IBOutlet weak var bro17: UIImageView!
    @IBOutlet weak var bro16: UIImageView!
    @IBOutlet weak var bro15: UIImageView!
    @IBOutlet weak var bro14: UIImageView!
    @IBOutlet weak var bro13: UIImageView!
    @IBOutlet weak var bro12: UIImageView!
    @IBOutlet weak var bro11: UIImageView!
    @IBOutlet weak var bro9: UIImageView!
    @IBOutlet weak var bro8: UIImageView!
    @IBOutlet weak var bro7: UIImageView!
    @IBOutlet weak var bro6: UIImageView!
    @IBOutlet weak var bro5: UIImageView!
    @IBOutlet weak var bro4: UIImageView!
    @IBOutlet weak var bro3: UIImageView!
    @IBOutlet weak var bro2: UIImageView!
    @IBOutlet weak var bro1: UIImageView!
    
    
    var timer = Timer()
    var timerHidden = Timer()
    var count = 0
    var score = 0
    var bros = [UIImageView]()
    var random2 = 18
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Bro Array
        
        bros = [bro1,bro2,bro3,bro4,bro5,bro6,bro7,bro8,bro9,bro10,bro11,bro12,bro13,bro14,bro15,bro16,bro17,bro18]
        
        
        //Time
        count = 20
        lblTime.text = String(count)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pageTimer), userInfo: nil, repeats: true)
        timerHidden = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(isHidden), userInfo: nil, repeats: true)
        
        //Score
        score = 0
        lblScore.text = "Score: 0"
        for item in bros {
            scorePlus(imgView: item)
            item.isHidden = true
        }
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            lblHighscore.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            lblHighscore.text = "Highscore: \(newScore)"
        }
        
    }
    
    
    
    // score
    func scorePlus(imgView:UIImageView){
        imgView.isUserInteractionEnabled = true
        let gestureGecognizer = UITapGestureRecognizer(target: self, action: #selector(scoreCalculate))
        imgView.addGestureRecognizer(gestureGecognizer)
    }
    
    @objc func scoreCalculate(){
        score += 1
        lblScore.text = "Score: \(score)"
    }
    
    
    
    //Alert
    func stopAlert(alertTitle: String, alertMessage: String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let btnReplay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
            self.viewDidLoad()
        }
        let btnOK = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(btnOK)
        alert.addAction(btnReplay)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    //Hidden
    @objc func isHidden(){
        for item in self.bros {
            item.isHidden = true
        }
        
        var random = Int(arc4random_uniform(UInt32(self.bros.count - 1)))
        if random == random2 {
            random = Int(arc4random_uniform(UInt32(self.bros.count - 1)))
            bros[random].isHidden = false
            random2 = random
        } else {
            bros[random].isHidden = false
            random2 = random
        }
        
        

    }
    
    
    //Time
    @objc func pageTimer(){
        count -= 1
        lblTime.text = String(count)
        
        
        if count == 0 {
            timer.invalidate()
            timerHidden.invalidate()
            lblTime.text = "Time is over"
            stopAlert(alertTitle: "Finish", alertMessage: "Time is over")
            for item in self.bros {
                item.isHidden = true
            }
                if score > highScore {
                    highScore = score
                    UserDefaults.standard.set(highScore, forKey: "highscore")
                    lblHighscore.text = "Hihgscore: \(highScore)"
                }
            
        }
        
    }


}

