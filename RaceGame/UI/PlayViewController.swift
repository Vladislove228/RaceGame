
import Foundation
import UIKit
import RealmSwift

class PlayViewController: UIViewController {
    
    @IBOutlet weak var startGameView: UIButton!
    @IBOutlet weak var striple1: UIView!
    @IBOutlet weak var striple2: UIView!
    @IBOutlet weak var roadView: UIImageView!
    @IBOutlet weak var breakView: UIImageView!
    @IBOutlet weak var carView: UIImageView!
    @IBOutlet weak var striple3: UIView!
    @IBOutlet weak var striple4: UIView!
    @IBOutlet weak var striple5: UIView!
    @IBOutlet weak var striple6: UIView!
    
    @IBOutlet weak var striple7: UIView!
    
    @IBOutlet weak var striple8: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    var breakView1 = UIImageView()
    var views : [UIView] = Array()
    var views1 : [UIView] = Array()
    var cnt = 0
    var cnt1 = 0
    var ptr = 0
    var speed1  = 0.0
    var leftAndRight = 100
    
//    var scored = Settings.settings ()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        createCar()
        makeShadow()
        breakView.isHidden = true
        scoreLabel.isHidden = true
        upButton.isHidden = true
        downButton.isHidden = true
        
        
        if let carIndex = UserDefaults.standard.double(forKey: .enteredCarIndex){
            Settings.indexCar = Int(carIndex)
            carView.image = Settings.carImage[Settings.indexCar ]
        
        }
        if let breakIndex = UserDefaults.standard.double(forKey: .enteredBreakIndex){
            Settings.indexBreak = Int(breakIndex)
            breakView.image = Settings.listOfImages[Settings.indexBreak ]
        }
        if let value1 = UserDefaults.standard.double(forKey: .enteredValue1) {
             speed1 = value1
            Settings.speed = speed1 / 100
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let newScore = Score(name: Settings.name, scoreValue: Settings.scoreValue)
       
        let realm = try! Realm()
        
        try? realm.write {
            realm.add(newScore)
            
            
        }
        print(Settings.scoreValue)
    }
    func setupUI() {
        startGameView.setTitle("startGameView".localized(), for: .normal)
       
    }
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         Settings.speed = speed1 / 100
         
         
    }
    
   
    
    func endGame(){
        dismiss(animated: true)
        
//        Settings.settings.score.append(Settings.settings.scoreValue)
//       print(Settings.settings.score)
//        scored.score.append(Settings.settings.scoreValue)
//       print(scored.score)
        
    }
    
    func score(){
        
        Timer.scheduledTimer(withTimeInterval: Settings.speed, repeats: true){ [self]  timer in
            
            Settings.scoreValue += 1
            scoreLabel.text = "\(Settings.scoreValue)"
            if Settings.scoreValue == 100 {
                Settings.speed /=  1.5
                leftAndRight -= 5
            }
            if Settings.scoreValue == 300 {
                Settings.speed /= 1.5
                leftAndRight -= 10
            }
            if Settings.scoreValue ==  500 {
                Settings.speed /= 1.5
                leftAndRight -= 15
            }
            if Settings.scoreValue ==  1000 {
                Settings.speed /= 1.5
                leftAndRight -= 20
            }
            
        }
        
    }
    func createCar(){
        carView.frame.origin.x = roadView.frame.minX + 100
        carView.frame.origin.y = self.roadView.frame.maxY -  self.roadView.frame.maxY / 3
        carView.image = Settings.carImage[Settings.indexCar ]
        
    }
    func makeShadow(){
        let darkGreen = UIColor(hex: 0xff4300)
        carView.dropShadow(color: darkGreen,
                        offset: CGSize(width: 0, height: 0),
                        radius: 10)
    }
    
    
    
    func initView(){
        ptr = 1
        let xCoord = CGFloat(CGFloat .random(in: view.frame.minX...view.frame.maxX - breakView.frame.height ))
        breakView1.frame = CGRect(x: xCoord , y: self.view.frame.minY, width: breakView.frame.width, height: breakView.frame.height)
        
        let image = Settings.listOfImages[Settings.indexBreak ]
        breakView1.image = image
        breakView1.contentMode = .scaleAspectFill
        roadView.addSubview(breakView1)
    }
    func makeBreak(){
        
        Timer.scheduledTimer(withTimeInterval: Settings.speed / 5 , repeats: false){ [self]  timer in
            
            if ptr == 0 {
                initView()
                
            }
            
            UIView.animate(withDuration: 0.001, delay: 0, options: [.curveLinear]){
                    if self.carView.frame.intersects(self.breakView1.frame){
                        
                        self.endGame()
             
                    }
                    self.breakView1.frame.origin.y += 5
                
                if self.breakView1.frame.origin.y >= self.view.frame.maxY +  3 * self.breakView1.frame.height{
                        self.breakView1.removeFromSuperview()
                    self.ptr = 0
                }
                    }completion: { _ in
                        self.makeBreak()
                        
                    
                }
   
        }

    }
    func makeBreak2(){
        
        Timer.scheduledTimer(withTimeInterval: Settings.speed / 5 , repeats: false){ [self]  timer in
            
            if ptr == 0 {
                initView()
                
            }
            
            UIView.animate(withDuration: 0.001, delay: 0, options: [.curveLinear]){
                    if self.carView.frame.intersects(self.breakView1.frame){
                        
                        self.endGame()
             
                    }
                    self.breakView1.frame.origin.y += 5
                
                if self.breakView1.frame.origin.y >= self.view.frame.maxY +  3 * self.breakView1.frame.height{
                        self.breakView1.removeFromSuperview()
                    self.ptr = 0
                }
                    }completion: { _ in
                        self.makeBreak2()
                        
                    
                }
   
        }
    }
    
   

    func moveLeft () {
        if roadView.superview!.frame.contains(carView.frame) {
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.x -= CGFloat(self.leftAndRight)
            self.carView.transform = CGAffineTransform(rotationAngle: -50.5)
        }completion: { _ in
            self.carView.transform = CGAffineTransform(rotationAngle: 0)
        }
        } else{
            endGame()
        }
    }
    
    func moveRight () {
        
        if roadView.superview!.frame.contains(carView.frame){
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.x += CGFloat(self.leftAndRight)
            self.carView.transform = CGAffineTransform(rotationAngle: +50.5)

        }completion: { _ in
           self.carView.transform = CGAffineTransform(rotationAngle: 0)
        }
        }else{
            
            endGame()
        }
    }
    func moveUP () {
        
        if roadView.superview!.frame.contains(carView.frame){
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.y += CGFloat(self.leftAndRight)
           

        }completion: { _ in
          
        }
        }else{
            dismiss(animated: true)
        }
    }
    func moveDown () {
        
        if roadView.superview!.frame.contains(carView.frame){
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.y -= CGFloat(self.leftAndRight)
            

        }completion: { _ in
           
        }
        }else{
            dismiss(animated: true)
        }
    }
    
    
    
    func hiddenAll(){
        striple1.isHidden = true
        striple2.isHidden = true
        striple3.isHidden = true
        striple4.isHidden = true
        striple5.isHidden = true
        striple6.isHidden = true
        striple7.isHidden = true
        striple8.isHidden = true
        breakView.isHidden = true
        scoreLabel.isHidden = false
        startGameView.isHidden = true
    }
    
    @IBAction func backButtonPRessed(_ sender: Any) {
        endGame()
        
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
            moveLeft()
    }
    
    
    @IBAction func rightButtonPressed(_ sender: Any) {
           moveRight()
    }
    @IBAction func upButtonPressed(_ sender: Any) {
        moveDown()
    }
    @IBAction func downButtonPressed(_ sender: Any) {
        moveUP()
    }
    @IBAction func startGame(_ sender: Any) {
      //  leftAndRight = 100
        
       
        makeBreak()
        makeBreak2()
        hiddenAll()
       score()
     //   print (Settings.settings.speed)
     //   print (speed1)
        Settings.scoreValue = 0
        
        
    }
}
