//
//  Score.swift
//  RaceGame
//
//  Created by Владислав Квинто on 01/08/2022.
//

import Foundation
import UIKit
import RealmSwift




class Score: Object {
    @Persisted var name: String
    @Persisted var scoreValue: Int
    
    convenience init(name: String, scoreValue: Int ) {
        self.init()
        self.name = name
        self.scoreValue = scoreValue
    }
    
    
}


