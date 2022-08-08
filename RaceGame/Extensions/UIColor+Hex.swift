

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xff) >> 0) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
