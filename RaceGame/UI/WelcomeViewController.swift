//
//  WelcomeViewController.swift
//  RaceGame
//
//  Created by Владислав Квинто on 07/09/2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var chooseControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveControl(gameControl: Settings.control)
    }
    
    private func saveControl(gameControl: Bool?){
        guard let gameControl = gameControl else {
            return
        }
        UserDefaults.standard.set(gameControl, forKey: .enteredControl)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
     
        Core.shared.setistwutNewUser()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseControl(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            Settings.control = true
        }else{
            Settings.control = false
        }
    }
    

}
