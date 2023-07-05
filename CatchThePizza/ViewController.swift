import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pizzaImg1: UIImageView!
    @IBOutlet weak var pizzaImg2: UIImageView!
    @IBOutlet weak var pizzaImg3: UIImageView!
    @IBOutlet weak var pizzaImg4: UIImageView!
    @IBOutlet weak var pizzaImg5: UIImageView!
    @IBOutlet weak var pizzaImg6: UIImageView!
    @IBOutlet weak var pizzaImg7: UIImageView!
    @IBOutlet weak var pizzaImg8: UIImageView!
    @IBOutlet weak var pizzaImg9: UIImageView!
    
    var pizzaArr = [UIImageView]()
    
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var pizzaTimer = Timer()
    var movePizzaTimer = Timer()
    var counter = 0
    var scoreCounter = 0
    var highscoreCounter = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        scoreLabel.text = "\(scoreCounter)"
        
        let strHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if strHighscore == nil {
            highscoreCounter = 0
            highscoreLabel.text = "\(highscoreCounter)"
        }
        
        if let newHighscore = strHighscore as? Int {
            highscoreCounter = newHighscore
            highscoreLabel.text = "\(highscoreCounter)"
        }
        
        counter = 20
        timerLabel.text = "\(counter)"
        pizzaTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        movePizzaTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(movePizza), userInfo: nil, repeats: true)
        pizzaArr = [pizzaImg1, pizzaImg2, pizzaImg3, pizzaImg4, pizzaImg5, pizzaImg6, pizzaImg7, pizzaImg8, pizzaImg9]
        
        pizzaImg1.isUserInteractionEnabled = true
        pizzaImg2.isUserInteractionEnabled = true
        pizzaImg3.isUserInteractionEnabled = true
        pizzaImg3.isUserInteractionEnabled = true
        pizzaImg4.isUserInteractionEnabled = true
        pizzaImg5.isUserInteractionEnabled = true
        pizzaImg6.isUserInteractionEnabled = true
        pizzaImg7.isUserInteractionEnabled = true
        pizzaImg8.isUserInteractionEnabled = true
        pizzaImg9.isUserInteractionEnabled = true
        
        let gestRec1 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec2 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec3 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec4 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec5 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec6 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec7 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec8 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        let gestRec9 = UITapGestureRecognizer(target: self, action: #selector(scoreFunc))
        
        pizzaImg1.addGestureRecognizer(gestRec1)
        pizzaImg2.addGestureRecognizer(gestRec2)
        pizzaImg3.addGestureRecognizer(gestRec3)
        pizzaImg4.addGestureRecognizer(gestRec4)
        pizzaImg5.addGestureRecognizer(gestRec5)
        pizzaImg6.addGestureRecognizer(gestRec6)
        pizzaImg7.addGestureRecognizer(gestRec7)
        pizzaImg8.addGestureRecognizer(gestRec8)
        pizzaImg9.addGestureRecognizer(gestRec9)

        movePizza()
    }
    
    @objc func timerFunc(){
        
        counter -= 1
        timerLabel.text = "\(counter)"
        
        if counter == 0 {
            pizzaTimer.invalidate()
            movePizzaTimer.invalidate()
            
            for pizz in pizzaArr {
                pizz.isHidden = true
            }
            
            let timeAlert = UIAlertController(title: "Try Again", message: "Time is Over!", preferredStyle: UIAlertController.Style.alert)

            let tryAgainButton = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.scoreCounter = 0
                self.scoreLabel.text = "\(self.scoreCounter)"
                self.counter = 20
                self.timerLabel.text = "\(self.counter)"
                self.pizzaTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
                self.movePizzaTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.movePizza), userInfo: nil, repeats: true)
            }
                
            timeAlert.addAction(tryAgainButton)
            self.present(timeAlert, animated: true, completion: nil)
            
        }
        
        if self.scoreCounter > self.highscoreCounter {
            self.highscoreCounter = self.scoreCounter
            highscoreLabel.text = "\(self.highscoreCounter)"
            UserDefaults.standard.set(self.highscoreCounter, forKey: "highscore")
        }
    }
    
    @objc func scoreFunc() {
        scoreLabel.text = "\(scoreCounter)"
        scoreCounter += 1
    }
    
    @objc func movePizza() {
        for pizz in pizzaArr {
            pizz.isHidden = true
        }
        
        let rndPizz = Int(arc4random_uniform(UInt32(pizzaArr.count - 1)))
        
        pizzaArr[rndPizz].isHidden = false
    }
}

