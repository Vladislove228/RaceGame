//
//  RecordTableViewCell.swift
//  RaceGame
//
//  Created by Владислав Квинто on 01/08/2022.
//

import UIKit
import RealmSwift
class RecordTableViewCell: UITableViewCell {
    var scores: Results<Score>?
    var observer: Any?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ScoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with score: Score){
        self.nameLabel.text = score.name
        self.ScoreLabel.text = "\(Int(score.scoreValue))"
    }
}
