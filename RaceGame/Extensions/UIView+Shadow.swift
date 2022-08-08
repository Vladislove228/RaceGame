import Foundation
import UIKit

extension UIView {
    func dropShadow(color: UIColor = .black,
                    offset: CGSize = CGSize(width: 5, height: 5),
                    opacity: Float = 0.7,
                    radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
