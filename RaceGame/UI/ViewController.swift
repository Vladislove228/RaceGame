
import UIKit
import RealmSwift
class ViewController: UIViewController {
    var a = 0
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var startLabel: UIButton!
    @IBOutlet var ratingLabel: UIButton!
    @IBOutlet var settingsLabel: UIButton!
    @IBOutlet weak var backGraundView: UIView!
    @IBOutlet weak var helloLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientView()
        setupUI()
     //   deleteDB()
    }
    func deleteDB() {
    let realm = try! Realm()
    let allUploadingObjects = realm.objects(ScoreDB.self)
        
    try! realm.write {
    realm.delete(allUploadingObjects)
        }
        
    }
    func setupUI() {
       
        startLabel.setTitle("startLabel".localized(), for: .normal)
        ratingLabel.setTitle("ratingLabel".localized(), for: .normal)
        settingsLabel.setTitle("settingsLabel".localized(), for: .normal)
        helloLabel.text = "helloLabel".localized()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    
        if let textName = UserDefaults.standard.string(forKey: .enteredValue) {
            Settings.name = textName
            nameLabel.text = "\(Settings.name)"
        }

    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        if Core.shared.isNewUser () {
            let vc = storyboard?.instantiateViewController(identifier: "welcome") as! WelcomeViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
            
    @IBAction func settingsButton(_ sender: Any) {
        let settingsViewController = SettingsViewController.instantiate()
        settingsViewController.modalPresentationStyle = .fullScreen
        present(settingsViewController, animated: true)
    }
    @IBAction func startButton(_ sender: Any) {
        let playViewController = PlayViewController.instantiate()
        playViewController.modalPresentationStyle = .fullScreen
        present(playViewController, animated: true)
    }
    
    @IBAction func tableButton(_ sender: Any) {
        
        let tableViewController = TableViewController.instantiate()
        tableViewController.modalPresentationStyle = .fullScreen
        present(tableViewController, animated: true)
    }
    
    private func createGradientView() {
   
        
       backGraundView.cornerRadius = 25
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = backGraundView.bounds
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.gray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)


      //  backGraundView.layer.addSublayer(gradientLayer)
        backGraundView.layer.insertSublayer(gradientLayer, at: 0)
        backGraundView.layer.masksToBounds = true

        
        
    }
    
   
    @IBAction func insertNameButton(_ sender: Any) {
       // insertNameAlert()
        print(Settings.name)
    }
    
    
    func insertNameAlert() {
        let alertController = UIAlertController(title: "Insert your name",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.isSecureTextEntry = true
        }
        let continueAction = UIAlertAction(title: "Ok",
                                           style: .default) { [weak alertController] _ in
                                            guard let textFields = alertController?.textFields else { return }
                                            
                                            if let nameText = textFields[0].text {
                                               
                                                print("Name: \(nameText)")
                                                self.helloLabel.text = "Hello \(nameText)"
                                                Settings.name = nameText
                                            }
            
        }

        alertController.addAction(continueAction)
        self.present(alertController,
                     animated: true)
    }
    
    
    
}

class Core {
    static let shared = Core()
    func isNewUser()-> Bool {
        
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }

    func setistwutNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
