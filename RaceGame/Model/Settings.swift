//
//  Settings.swift
//  RaceGame
//
//  Created by Владислав Квинто on 28/05/2022.
//

import Foundation
import UIKit



struct Settings {
    static var speed : Double = 0.0
    static  var listOfImages: [UIImage] = [
        UIImage(named: "2.png")!,
        UIImage(named: "3.svg")!,
        UIImage(named: "4.svg")!
        
    ]
    static  var carImage: [UIImage] = [
        UIImage(named: "car1.png")!,
        UIImage(named: "car2.png")!
    ]
    static var name : String = ""
    
    static var indexCar = 0
    
    static var indexBreak = 0

    var score : [Int] = []
    
    static var scoreValue = 0
}

    
    

