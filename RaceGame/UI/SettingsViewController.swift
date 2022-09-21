//
//  SettingsViewController.swift
//  RaceGame
//
//  Created by Владислав Квинто on 13/04/2022.
//


import Foundation
import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet var breakLabel: UILabel!
    @IBOutlet var carLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var brealView: UIView!
    @IBOutlet weak var carView: UIView!
    @IBOutlet var BreakTapGesture: UITapGestureRecognizer!
    @IBOutlet var CarTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var speedField: UITextField!
    @IBOutlet weak var carViewImage: UIImageView!
    @IBOutlet weak var breakViewImage: UIImageView!
    @IBOutlet var musicSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCarGestureRecognizer()
        setupBreakGestureRecognizer()
        
        if let text = UserDefaults.standard.string(forKey: .enteredValue) {
            nameField.text = text
        }
     
        
        if let text1 = UserDefaults.standard.string(forKey: .enteredValue1) {
            speedField.text = text1
        }
        
        if let value1 = UserDefaults.standard.double(forKey: .enteredValue1) {
            Settings.speed = value1
        }
        if let textName = UserDefaults.standard.string(forKey: .enteredValue) {
            Settings.name = textName
        }
        
        if let carIndex = UserDefaults.standard.double(forKey: .enteredCarIndex){
            Settings.indexCar = Int(carIndex)
            carViewImage.image = Settings.carImage[Settings.indexCar ]
           
        }
        if let breakIndex = UserDefaults.standard.double(forKey: .enteredBreakIndex){
            Settings.indexBreak = Int(breakIndex)
            breakViewImage.image = Settings.listOfImages[Settings.indexBreak ]
        }
        if let musicSliderValue = UserDefaults.standard.float(forKey: .enteredMusic){
            Settings.musicValue = Float(musicSliderValue)
            musicSlider.value = Settings.musicValue
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        save(text: nameField.text)
        save1(text1: speedField.text)
        
        saveCarIndex(carIndex: Settings.indexCar)
        saveBreakIndex(breakIndex: Settings.indexBreak)
        saveMusic(musicSliderValue: Settings.musicValue)
    }
    func setupUI(){
        nameLabel.text = "nameLabel".localized()
        speedLabel.text = "speedLabel".localized()
        carLabel.text = "carLabel".localized()
        breakLabel.text = "breakLabel".localized()
        
    }
    func setupCarGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapCar))
        carView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupBreakGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapBreak))
        brealView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc
    func handleTapCar(_ sender: UITapGestureRecognizer) {
        setupImagesCarChanges()
    }
    @objc
    func handleTapBreak(_ sender: UITapGestureRecognizer) {
        setupImagesBreakChanges()
    }
    
    
    
    private func setupImagesCarChanges() {
         Settings.indexCar += 1
        if Settings.indexCar  == Settings.carImage.count {
            Settings.indexCar  = 0
        }
        let image = Settings.carImage[Settings.indexCar ]
        carViewImage.image = image
       
        carViewImage.contentMode = .scaleAspectFit
        
   //     print(Settings.settings.indexCar )
        
    }
    
    private func setupImagesBreakChanges() {
         Settings.indexBreak += 1
        if Settings.indexBreak  == Settings.listOfImages.count {
            Settings.indexBreak  = 0
        }
        let image = Settings.listOfImages[Settings.indexBreak ]
        breakViewImage.image = image
       
        breakViewImage.contentMode = .scaleAspectFit
        
     //   print (Settings.settings.indexBreak )
        
        
        
    }
    
    private func saveCarIndex(carIndex: Int?) {
        guard let carIndex = carIndex else {
            return
        }
        UserDefaults.standard.set(carIndex, forKey: .enteredCarIndex)
    }
    private func saveBreakIndex(breakIndex: Int?) {
        guard let breakIndex = breakIndex else {
            return
        }
        UserDefaults.standard.set(breakIndex, forKey: .enteredBreakIndex)
    }
    
    private func save(text: String?) {
        guard let text = text else {
            return
        }
        UserDefaults.standard.set(text, forKey: .enteredValue)
    }
    private func save1(text1: String?) {
        guard let text1 = text1 else {
            return
        }
        UserDefaults.standard.set(text1, forKey: .enteredValue1)
    }
    private func saveMusic(musicSliderValue: Float?){
        guard let musicSliderValue = musicSliderValue else {
            return
        }
        UserDefaults.standard.set(musicSliderValue, forKey: .enteredMusic)
    }

    
    @IBAction func buttonBackPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
//        save(text: nameField.text)
//        save1(text1: speedField.text)
//        
//        saveCarIndex(carIndex: Settings.indexCar)
//        saveBreakIndex(breakIndex: Settings.indexBreak)
       
                            
     
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        Settings.audioPlayer.volume = musicSlider.value
        Settings.musicValue = musicSlider.value
        
    }
}


