//
//  String+extension.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.0
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.alignment = self.textAlignment

        let attrString = NSMutableAttributedString()
        if (self.attributedText != nil) {
            attrString.append( self.attributedText!)
        } else {
            attrString.append( NSMutableAttributedString(string: self.text!))
            attrString.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attrString.length))
        }
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat) -> NSAttributedString {


        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }
}



extension String{
//    func currencyInputFormatting() -> String {
//
//        var number: NSNumber!
//               let formatter = NumberFormatter()
//               formatter.numberStyle = .currencyAccounting
//               formatter.currencySymbol = currency
//               formatter.maximumFractionDigits = 2
//               formatter.minimumFractionDigits = 2
//
//               var amountWithPrefix = self
//
//               // remove from String: "$", ".", ","
//               let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
//               amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
//
//               let double = (amountWithPrefix as NSString).doubleValue
//               number = NSNumber(value: (double / 100))
//
//               // if first number is 0 or all numbers were deleted
//               guard number != 0 as NSNumber else {
//                   return ""
//               }
//
//               return formatter.string(from: number)!
//    }
    
  
    
   // hexStringToUIColor(hex: "#7F7F7F")
    func withsttributedText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: FontBook.regular.of(size:FontSize.size15.rawValue)]
      let range = (self as NSString).range(of: text)
         //fullString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range:range)

      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }

}

//extension NSMutableAttributedString {
//
//    func setColorForStr(textToFind: String, color: UIColor) {
//
//        let range = self.mutableString.range(of: textToFind, options:NSString.CompareOptions.caseInsensitive);
//        if range.location != NSNotFound {
//            self.addAttribute(NSForegroundColorAttributeName, value: color, range: range);
//        }
//
//    }
//}
//extension UIColor {
//    convenience init(hexString: String) {
//           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//           var int = UInt64()
//           Scanner(string: hex).scanHexInt64(&int)
//           let a, r, g, b: UInt64
//           switch hex.count {
//           case 3: // RGB (12-bit)
//               (a, r, g, b) = (255, (int >> 8)  17, (int >> 4 & 0xF)  17, (int & 0xF) * 17)
//           case 6: // RGB (24-bit)
//               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//           case 8: // ARGB (32-bit)
//               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//           default:
//               (a, r, g, b) = (255, 0, 0, 0)
//           }
//           self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//       }
//}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


// underline label extension

extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
          attributedText = attributedString
        }
    }
}
