
import Foundation
import UIKit
import RealmSwift
import AVFoundation
import CoreMotion

class PlayViewController: UIViewController {
    
    @IBOutlet weak var startGameView: UIButton!
    @IBOutlet weak var roadView: UIImageView!
    @IBOutlet weak var breakView: UIImageView!
    @IBOutlet weak var carView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var scoreFinishLabel: UILabel!
    
    @IBOutlet var roadViewMain: UIImageView!
    @IBOutlet var finishView: UIView!
    @IBOutlet var shareButton: UIButton!
    
    var roadView1 = UIImageView()
    var roadView2 = UIImageView()
    var breakView1 = UIImageView()
    var views : [UIView] = Array()
    var views1 : [UIView] = Array()
    var cnt = 0
    var cnt1 = 0
    var ptr = 0
    var speed1  = 0.0
    var leftAndRight = 80
    var upAndDown = 150
    var valueFalse = 0
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        roadView.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
        roadView.contentMode = .scaleToFill
        setupUI()
        createCar()
        makeShadow()
        playMusic()
        hiddenStart()
        
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
        if let musicSliderValue = UserDefaults.standard.float(forKey: .enteredMusic){
            Settings.musicValue = Float(musicSliderValue)
            Settings.audioPlayer.volume = Settings.musicValue
        }
        if let gameControl = UserDefaults.standard.bool(forKey: .enteredControl){
            Settings.control = Bool(gameControl)
           
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Settings.speed = speed1 / 100
        Settings.scoreValue = 0
        
    }
    override func viewDidAppear(_ animated: Bool){
 
    }
    
    override func didReceiveMemoryWarning(){
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let newScore = ScoreDB(name: Settings.name, scoreValue: Settings.scoreValue)
        
        let realm = try! Realm()
        
        try? realm.write {
            realm.add(newScore)
            
            
        }
        Settings.speed = speed1 / 100
    //    Settings.audioPlayer.stop()
        Settings.scoreValue = 0
    }
    
    
    func playMusic(){
        
        do {
            Settings.audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "mp3")!))
            Settings.audioPlayer.prepareToPlay()
        }catch{
            
        }
    }
    
    
    func setupUI() {
        startGameView.setTitle("startGameView".localized(), for: .normal)
       
    }
     
    
   
    
    func endGame(){

        scoreFinishLabel.text = "Your score - \(Settings.scoreValue)"
        leftButton.isHidden = true
        rightButton.isHidden = true
        finishView .isHidden = false
        scoreLabel.isHidden = true
        breakView1.isHidden = true
        
        //carView.isHidden = true
        //print(Settings.scoreValue)
     
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
            if Settings.scoreValue ==  2000 {
                Settings.speed /= 1.5
                leftAndRight -= 25
            }
            
            if self.valueFalse == 0 && self.carView.frame.intersects(self.breakView1.frame) {
            timer.invalidate()
                endGame()
            }
            if roadView.superview!.frame.contains(carView.frame){
                
            }else{
                timer.invalidate()
                endGame()
            }
        }
        
    }
    func createCar(){
        carView.frame.origin.x = view.frame.minX + 100
        carView.frame.origin.y = self.view.frame.maxY -  self.view.frame.maxY / 4
        
        carView.image = Settings.carImage[Settings.indexCar ]
        
   
       // carView.backgroundColor = .black
        
    }
    func makeShadow(){
        let darkGreen = UIColor(hex: 0xff4300)
        carView.dropShadow(color: darkGreen,
                        offset: CGSize(width: 0, height: 0),
                        radius: 10)
    }
    
    
    
    func initView(){
        ptr = 1
        let xCoord = CGFloat(CGFloat .random(in: view.frame.minX...view.frame.maxX - 2 * breakView.frame.width ))
        breakView1.frame = CGRect(x: xCoord , y: self.view.frame.minY, width: breakView.frame.width , height: breakView.frame.height)
        
        let image = Settings.listOfImages[Settings.indexBreak ]
        breakView1.image = image
        breakView1.contentMode = .scaleAspectFill
      //  breakView1.backgroundColor = .cyan
        view.addSubview(breakView1)
    }
    func makeBreak(){
        
        Timer.scheduledTimer(withTimeInterval: 0.001 , repeats: false){ [self]  timer in

            if ptr == 0 {
                initView()

            }
            
            UIView.animate(withDuration: Settings.speed / 4, delay: 0, options: [.curveLinear]){
                if self.valueFalse == 0 && self.carView.frame.intersects(self.breakView1.frame){
                    if self.carView.frame.intersects(self.breakView1.frame){
    
                        self.endGame()
                        self.breakView1.layer.removeAllAnimations()
                    }
                }
                    self.breakView1.frame.origin.y += 5
                
                if self.breakView1.frame.origin.y >= self.view.frame.maxY +  3 * self.breakView1.frame.height{
                        self.breakView1.removeFromSuperview()
                    self.ptr = 0
                }
                    }completion: { _ in

                        self.makeBreak()
                        
                    
                }
            if self.valueFalse == 0 && self.carView.frame.intersects(self.breakView1.frame) {
            timer.invalidate()
                endGame()
            }
            if roadView.superview!.frame.contains(carView.frame){
                
            }else{
                timer.invalidate()
                endGame()
            }
        }

    }
    func makeRoad(){
        roadView1.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - view.frame.height, width: view.frame.width, height: view.frame.height)
        roadView1.image = UIImage(named: "road.jpeg")
        roadView1.contentMode = .scaleToFill
        roadView2.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y - 2 * view.frame.height, width: view.frame.width, height: view.frame.height)
        roadView2.image = UIImage(named: "road.jpeg")
        roadView2.contentMode = .scaleToFill
        roadViewMain.addSubview(roadView1)
        roadViewMain.addSubview(roadView2)
        Timer.scheduledTimer(withTimeInterval: Settings.speed / 4 , repeats: true){ [self]  timer in
            
            
            UIView.animate(withDuration: 0.001, delay: 0, options: [.curveLinear]){
                
                self.roadView.frame.origin.y += 5
                self.roadView1.frame.origin.y += 5
                self.roadView2.frame.origin.y += 5
                if self.roadView.frame.origin.y >= self.view.frame.height {
                    self.roadView.frame.origin.y = self.view.frame.origin.y - 2 * self.view.frame.height
                }
                if self.roadView1.frame.origin.y >= self.view.frame.height {
                    self.roadView1.frame.origin.y = self.view.frame.origin.y - 2 * self.view.frame.height
                }
                if self.roadView2.frame.origin.y >= self.view.frame.height {
                    self.roadView2.frame.origin.y = self.view.frame.origin.y - 2 * self.view.frame.height
                }
            
                    }completion: { _ in
                       
                }
            if self.valueFalse == 0 && self.carView.frame.intersects(self.breakView1.frame) {
            timer.invalidate()
                endGame()
            }
            if roadView.superview!.frame.contains(carView.frame){
                
            }else{
                timer.invalidate()
                endGame()
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
    func moveDown () {
        
        if roadView.superview!.frame.contains(carView.frame){
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.y += CGFloat(self.upAndDown)
           

        }completion: { _ in
          
        }
        }else{
            endGame()
        }
    }
    
    func moveUP () {
        
        if roadView.superview!.frame.contains(carView.frame){
        UIView.animate(withDuration: 0.5, delay: 0, options: []){
            self.carView.center.y -= CGFloat(self.upAndDown)
            

        }completion: { _ in
           
        }
        }else{
            endGame()
        }
    }
    
    func hiddenStart(){
        finishView.isHidden = true
        breakView.isHidden = true
        scoreLabel.isHidden = true
      
        rightButton.isHidden = true
        leftButton.isHidden = true
    }
    
    func hiddenFinish(){

        breakView.isHidden = true
        scoreLabel.isHidden = false
        startGameView.isHidden = true
        
        if Settings.control == false{
            leftButton.isHidden = false
            rightButton.isHidden = false
            
        }
    }
    
    func accelerometer (){
        motionManager.accelerometerUpdateInterval=0.3
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
                {
                if myData.acceleration.x > 0.2{
                    self.moveRight()
                }
                if myData.acceleration.x < -0.2{
                    self.moveLeft()
                }
                   
                }
            }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            moveUP()
            valueFalse = 1
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false){ [self]  timer in
                valueFalse = 0
            }
        }
    }
    @IBAction func backButtonPRessed(_ sender: Any) {
        dismiss(animated: true)
        Settings.audioPlayer.stop()
        
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
        moveLeft()
        
        }
    @IBAction func rightButtonPressed(_ sender: Any) {
        moveRight()
       
    }
    @IBAction func upButtonPressed(_ sender: Any) {
        moveUP()
    }
    @IBAction func downButtonPressed(_ sender: Any) {
        moveDown()
    }
    @IBAction func startGame(_ sender: Any) {
      //  leftAndRight = 100
        if Settings.control == true{
            
            accelerometer()
        }
        makeBreak()
        makeRoad()
        hiddenFinish()
       score()
     //   print (Settings.settings.speed)
     //   print (speed1)
        Settings.scoreValue = 0
        Settings.audioPlayer.play()
        
    }
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: ["My score in RaceGame - \(scoreLabel.text!)"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}
