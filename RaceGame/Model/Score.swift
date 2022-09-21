

import Foundation

struct Score: Equatable {
    let name: String
    let scoreValue: Int
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name.lowercased() == rhs.name.lowercased()
    }
}

extension Score {
    init(_ score: ScoreDB) {
        self.init(name: score.name, scoreValue: score.scoreValue )
    }
}
