//
//  Themes.swift
//  Gas 2 You
//
//  Created by MacMini on 29/07/21.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

//==========================
//MARK:- === Label ===
//==========================

class themeLabel: UILabel{
    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
    @IBInspectable public var isBold: Bool = false
    @IBInspectable public var isSemibold: Bool = false
    @IBInspectable public var isLight: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var isRegular: Bool = false
    @IBInspectable public var fontColor: UIColor = .black
    @IBInspectable public var isThemeColour : Bool = false
    @IBInspectable public var is50Oppacity : Bool = false
    @IBInspectable public var is8ppacity : Bool = false
    @IBInspectable public var IsUnderLine : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

            if isBold {
                self.font = CustomFont.PoppinsBold.returnFont(Font_Size)
            } else if isSemibold {
                self.font = CustomFont.PoppinsSemiBold.returnFont(Font_Size)
            } else if isMedium {
                self.font = CustomFont.PoppinsMedium.returnFont(Font_Size)
            } else if isLight {
                self.font = CustomFont.PoppinsLight.returnFont(Font_Size)
            } else {
                self.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
            }
        
        if IsUnderLine {
            let attributedString = NSMutableAttributedString(string: self.text ?? "", attributes:  [.foregroundColor: fontColor,.underlineStyle: NSUnderlineStyle.single.rawValue])
            
                 self.attributedText = attributedString
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
            if is50Oppacity == true {
                self.textColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
            }
            else if is8ppacity == true {
                self.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:0.13)
            }
            else {
                self.textColor = isThemeColour == true ? UIColor.appColor(ThemeColor.themeBlue) : fontColor
            }
    }
}


//==========================
//MARK: ====== Button ======
//==========================


class ThemeButton: UIButton {
    
    @IBInspectable public var Font_Size: CGFloat = FontSize.size19.rawValue
    @IBInspectable public var isBold: Bool = false
    @IBInspectable public var isSemibold: Bool = false
    @IBInspectable public var isLight: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var isRegular: Bool = false
    @IBInspectable public var isbordered: Bool = false
    @IBInspectable public var background : UIColor = UIColor.appColor(ThemeColor.themeBlue)
    @IBInspectable public var fontColor: UIColor = UIColor.appColor(ThemeColor.themeBlue)
    @IBInspectable public var shadowColor: UIColor = UIColor.lightGray
    @IBInspectable public var radius: CGFloat = 0.0
//    @IBInspectable public var shadow: Bool = false

    var activityIndicator: UIActivityIndicatorView!
    var originalButtonText: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel?.font = FontBook.semibold.staticFont(size: Font_Size)
        self.backgroundColor = background
        self.tintColor = fontColor
        self.layer.cornerRadius = radius
        
        if isBold {
            self.titleLabel?.font = CustomFont.PoppinsBold.returnFont(Font_Size)
        } else if isSemibold {
            self.titleLabel?.font = CustomFont.PoppinsSemiBold.returnFont(Font_Size)
        } else if isMedium {
            self.titleLabel?.font = CustomFont.PoppinsMedium.returnFont(Font_Size)
        } else if isLight {
            self.titleLabel?.font = CustomFont.PoppinsLight.returnFont(Font_Size)
        } else if isRegular {
            self.titleLabel?.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
        } else {
            self.titleLabel?.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
        }
        
        
        if isbordered {
            self.setunderline(title: self.titleLabel?.text ?? "", color: UIColor.appColor(ThemeColor.themeButtonBlue), font: CustomFont.PoppinsRegular.returnFont(Font_Size))
        }
//        if shadow {
//            addShadow(view: self, shadowColor: shadowColor)
//        }
    }
    
    func showLoading() {
            isEnabled = false
            originalButtonText = self.titleLabel?.text

            self.setTitle("", for: .normal)
            if (activityIndicator == nil) {
                activityIndicator = createActivityIndicator()
            }

            showSpinning()
        }

        func hideLoading() {
            isEnabled = true
            self.setTitle(originalButtonText, for: .normal)
            activityIndicator.stopAnimating()
        }

        private func createActivityIndicator() -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .white
            return activityIndicator
        }

        private func showSpinning() {
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(activityIndicator)
            centerActivityIndicatorInButton()
            activityIndicator.startAnimating()
        }

        private func centerActivityIndicatorInButton() {
            let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
            self.addConstraint(xCenterConstraint)

            let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
            self.addConstraint(yCenterConstraint)
        }

        override var isEnabled: Bool {
            didSet {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = UIColor.appColor(ThemeColor.themeBlue)
                }
            }
        }
    
}

class writeTextView: UIView {
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.1098039216, green: 0.4588235294, blue: 0.7333333333, alpha: 0.3)
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
    }
    
}

class themeButton: UIButton {
    @IBInspectable public var Font_Size: CGFloat = FontSize.size19.rawValue
    @IBInspectable public var fontColor: UIColor = UIColor.appColor(ThemeColor.themeButtonBlue)
    @IBInspectable public var IsSubmit : Bool = false
    @IBInspectable public var IsBlack : Bool = false
    @IBInspectable public var IsUnderline : Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if IsSubmit {
            self.backgroundColor = UIColor.appColor(ThemeColor.themeButtonBlue)
            self.setTitleColor(fontColor, for: .normal)
            self.titleLabel?.font = CustomFont.PoppinsBold.returnFont(Font_Size)
        } else if IsBlack {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(fontColor, for: .normal)
            self.titleLabel?.font = CustomFont.PoppinsMedium.returnFont(Font_Size)
        } else {
            self.backgroundColor = UIColor.clear
            self.setTitleColor(fontColor, for: .normal)
            self.titleLabel?.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
        }
        if IsUnderline {
            self.setunderline(title: self.titleLabel?.text ?? "", color: fontColor, font: CustomFont.PoppinsRegular.returnFont(Font_Size))
        }
        
    }
}



class ThemeCompleteButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
            self.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:0.23), for: .normal)
            self.backgroundColor = .clear
            self.titleLabel?.font  =  FontBook.regular.of(size: 14.0)
            self.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha:0.23).cgColor
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 10
            

    }
}




class themeRoundBtn : UIButton {
    
    @IBInspectable var isRed : Bool = false
    @IBInspectable var isCornerRound : Bool = false
    override func awakeFromNib() {
           super.awakeFromNib()
        self.layer.cornerRadius = isCornerRound == true ? 8 : self.frame.height / 2
           self.clipsToBounds = true
        self.backgroundColor = isRed == true ? UIColor(hexString: "C94B4B") : .white
        
       }
       
}

class themeCustomShadowButton : UIControl {
    @IBInspectable public var front_image: UIImage = UIImage(named: "s") ?? UIImage()
    @IBInspectable public var Font_Size: CGFloat = FontSize.size19.rawValue
    @IBInspectable public var fontColor: UIColor = UIColor.appColor(.themeBlue)
    @IBInspectable public var Title: String = ""
    @IBInspectable public var isYellowBG : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSoftUIEffectForView(yellowBG: isYellowBG)
        
        let imageView = UIImageView(image: front_image)
//        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width - 10, height: self.frame.height - 10)
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(imageView)
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: imageView.frame.width - 10, height: imageView.frame.height - 10))
        label.text = Title
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.font = FontBook.regular.of(size: Font_Size)
        label.textColor = fontColor
        imageView.addSubview(label)
        
        if isYellowBG {
            label.textColor = .black
        }
        
        
    }
}

class ThemeGrayButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.backgroundColor =  UIColor(hexString: "414141")
        self.titleLabel?.font  = FontBook.regular.of(size: 13.0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1.0)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.5
        
        
    }
}

class CustomShadowButton: UIButton {

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!

        backgroundColor =  UIColor(hexString: "#707070")
        
    }

    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }

    func updateLayerProperties() {
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height / 2

        //superview is your optional embedding UIView
        if let superview = superview {
            superview.backgroundColor = UIColor.clear
            superview.layer.shadowColor = UIColor.darkGray.cgColor
            superview.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 12.0).cgPath
            superview.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            superview.layer.shadowOpacity = 0.5
            superview.layer.shadowRadius = 2
            superview.layer.masksToBounds = true
            superview.clipsToBounds = false
        }
    }

}


class ThemeGradientButton: UIButton {

 
    public let buttongradient: CAGradientLayer = CAGradientLayer()

    override var isSelected: Bool {  // or isHighlighted?
        didSet {
            updateGradientColors()
        }
    }

    func updateGradientColors() {
        let colors: [UIColor]

        
        self.titleLabel?.font = FontBook.regular.of(size:13.0)
        self.setTitleColor(UIColor.white, for: .normal)
        colors = [UIColor(hexString: "2F2F2F") , UIColor(hexString: "414141")]
        
        buttongradient.colors = colors.map { $0.cgColor }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGradient()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateGradient()
    }

    func setupGradient() {
        buttongradient.startPoint = CGPoint(x: 1.0, y: 0.0)
        buttongradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.insertSublayer(buttongradient, at: 0)

        updateGradientColors()
    }

    func updateGradient() {
        buttongradient.frame = self.bounds
       
    }
}



//==========================
//MARK: === Textfield ===
//==========================

protocol textFieldDelegate {
    func didTapRightButton()
}

class themeTextfieldWithNoPaste : UITextField{
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
         if action == #selector(UIResponderStandardEditActions.paste(_:)) {
             return false
         }
         return super.canPerformAction(action, withSender: sender)
    }
    
    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
    @IBInspectable public var Border_Width: CGFloat = 1.0
    @IBInspectable public var Border_Color: UIColor = .clear
    @IBInspectable public var Corner_Radius: CGFloat = 1
    @IBInspectable public var isBold: Bool = false
    @IBInspectable public var isSemibold: Bool = false
    @IBInspectable public var isLight: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var isRegular: Bool = false
    @IBInspectable public var isPasteDisabled: Bool = false
    @IBInspectable public var fontColor: UIColor = .white
    @IBInspectable public var placeholderColor: UIColor = .white
    
    @IBInspectable var rightButton: String? {
        didSet {
            if let titleText = rightButton {
                rightViewMode = .always
                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
                button.setTitle(titleText, for: .normal)
                button.setColorFont(color: .gray , font: FontBook.regular.staticFont(size: Font_Size - 2))
                button.addTarget(self, action: #selector(rightImageAction), for: .touchUpInside)
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 80, height: 40))
                view.addSubview(button)
                rightView = view
            } else {
                rightViewMode = .never
            }
        }
    }

    @objc func rightImageAction() {
        print("button pressed")
    }
    
    @IBInspectable var LeftImage: UIImage? {
        didSet {
            if let image = LeftImage {
              //  SetLeftImage(image: image)
                leftViewMode = .always
                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
                //let imageView = UIImageView(frame: )
                button.setImage(image, for: .normal)

                button.contentMode = .scaleAspectFit
                button.tintColor = tintColor
                button.isUserInteractionEnabled = false
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: 20))
                view.isUserInteractionEnabled = false
                view.addSubview(button)
                leftView = view
            }else{
                leftViewMode = .never
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isBold {
            self.font = CustomFont.PoppinsBold.returnFont(Font_Size)
        } else if isSemibold {
            self.font = CustomFont.PoppinsSemiBold.returnFont(Font_Size)
        } else if isMedium {
            self.font = CustomFont.PoppinsMedium.returnFont(Font_Size)
        } else if isLight {
            self.font = CustomFont.PoppinsLight.returnFont(Font_Size)
        } else {
            self.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
        }
        self.textColor = fontColor
       
//        self.font = FontBook.regular.of(size : Font_Size)
        
        self.layer.borderWidth = Border_Width
        self.layer.borderColor = Border_Color.cgColor
        self.layer.cornerRadius = Corner_Radius
        
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor] )
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }
}


class themeTextfield : UITextField{

    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
    @IBInspectable public var Border_Width: CGFloat = 1.0
    @IBInspectable public var Border_Color: UIColor = .clear
    @IBInspectable public var Corner_Radius: CGFloat = 1
    @IBInspectable public var isBold: Bool = false
    @IBInspectable public var isSemibold: Bool = false
    @IBInspectable public var isLight: Bool = false
    @IBInspectable public var isMedium: Bool = false
    @IBInspectable public var isRegular: Bool = false
    @IBInspectable public var isPasteDisabled: Bool = false
    @IBInspectable public var fontColor: UIColor = .white
    @IBInspectable public var placeholderColor: UIColor = .white
    
    @IBInspectable var rightButton: String? {
        didSet {
            if let titleText = rightButton {
                rightViewMode = .always
                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 60, height: 40))
                button.setTitle(titleText, for: .normal)
                button.setColorFont(color: .gray , font: FontBook.regular.staticFont(size: Font_Size - 2))
                button.addTarget(self, action: #selector(rightImageAction), for: .touchUpInside)
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 80, height: 40))
                view.addSubview(button)
                rightView = view
            } else {
                rightViewMode = .never
            }
        }
    }

    @objc func rightImageAction() {
        print("button pressed")
    }
    
    @IBInspectable var LeftImage: UIImage? {
        didSet {
            if let image = LeftImage {
              //  SetLeftImage(image: image)
                leftViewMode = .always
                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
                //let imageView = UIImageView(frame: )
                button.setImage(image, for: .normal)

                button.contentMode = .scaleAspectFit
                button.tintColor = tintColor
                button.isUserInteractionEnabled = false
                let view = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: 20))
                view.isUserInteractionEnabled = false
                view.addSubview(button)
                leftView = view
            }else{
                leftViewMode = .never
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isBold {
            self.font = CustomFont.PoppinsBold.returnFont(Font_Size)
        } else if isSemibold {
            self.font = CustomFont.PoppinsSemiBold.returnFont(Font_Size)
        } else if isMedium {
            self.font = CustomFont.PoppinsMedium.returnFont(Font_Size)
        } else if isLight {
            self.font = CustomFont.PoppinsLight.returnFont(Font_Size)
        } else {
            self.font = CustomFont.PoppinsRegular.returnFont(Font_Size)
        }
        self.textColor = fontColor
       
//        self.font = FontBook.regular.of(size : Font_Size)
        
        self.layer.borderWidth = Border_Width
        self.layer.borderColor = Border_Color.cgColor
        self.layer.cornerRadius = Corner_Radius
        
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor] )
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        if LeftImage != nil {
            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        } else {
            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            return bounds.inset(by: padding)
        }
        
    }
}

class SingleDigitField: UITextField {
    var pressedDelete = false
    override func willMove(toSuperview newSuperview: UIView?) {
        keyboardType = .numberPad
        textAlignment = .center
        backgroundColor = .clear
        isSecureTextEntry = false
        isUserInteractionEnabled = false
        clipsToBounds = true
        font = CustomFont.medium.returnFont(17)
        tintColor = #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
    }
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
    }
}


class themeSearchBar: UITextField {

    

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 25);

    

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: padding)

    }

    

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: padding)

    }

    

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: padding)

    }

}




//class themeTextfield : UITextField{
//
//    @IBInspectable public var Font_Size: CGFloat = FontSize.size15.rawValue
//    @IBInspectable public var Border_Width: CGFloat = 1.0
//    @IBInspectable public var Corner_Radius: CGFloat = 1
//
//    @IBInspectable var rightImage: UIImage? {
//        didSet {
//            if let image = rightImage {
//                rightViewMode = .always
//                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
//                //let imageView = UIImageView(frame: )
//                button.setImage(image, for: .normal)
//
//                button.contentMode = .scaleAspectFit
//                button.tintColor = tintColor
//                button.isUserInteractionEnabled = false
//                let view = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: 20))
//                view.isUserInteractionEnabled = false
//                view.addSubview(button)
//                rightView = view
//            }else{
//                rightViewMode = .never
//            }
//        }
//    }
//
//    @IBInspectable var LeftImage: UIImage? {
//        didSet {
//            if let image = LeftImage {
//              //  SetLeftImage(image: image)
//                leftViewMode = .always
//                let button = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
//                //let imageView = UIImageView(frame: )
//                button.setImage(image, for: .normal)
//
//                button.contentMode = .scaleAspectFit
//                button.tintColor = tintColor
//                button.isUserInteractionEnabled = false
//                let view = UIView(frame : CGRect(x: 0, y: 0, width: 40, height: 20))
//                view.isUserInteractionEnabled = false
//                view.addSubview(button)
//                leftView = view
//            }else{
//                leftViewMode = .never
//            }
//        }
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.font = FontBook.regular.of(size : Font_Size)
//
//        self.layer.borderWidth = Border_Width
//        self.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
//        self.layer.cornerRadius = Corner_Radius
//
//        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
//                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.appColor(ThemeColor.ThemePlaceHolderTextColor)] )
//
//    }
//
//    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override open func textRect(forBounds bounds: CGRect) -> CGRect {
//
//        if LeftImage != nil {
//            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        } else {
//            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        }
//
//    }
//
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        if LeftImage != nil {
//            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        } else {
//            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        }
//
//    }
//
//    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
//
//        if LeftImage != nil {
//            let padding = UIEdgeInsets(top: 10, left: 10 + 30, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        } else {
//            let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//            return bounds.inset(by: padding)
//        }
//
//    }
//}


//you have to add its library in order to use this class

//class ThemeSkyTextfield : SkyFloatingLabelTextField {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.font =  FontBook.regular.of(size : FontSize.size20.rawValue)
//        self.placeholderFont = FontBook.regular.of(size : FontSize.size20.rawValue)
//        self.lineColor = UIColor.clear
//        self.selectedLineColor = UIColor.clear
//        self.selectedTitleColor = UIColor.appColor(.themeGrayText)
//        self.titleColor = UIColor.appColor(.themeGrayText)
//            //UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        self.placeholderColor = UIColor.white
//        self.textColor = UIColor.white
//
//    }
//}


class ThemeView : UIView {
    
    @IBInspectable public var isShadow: Bool = false
    @IBInspectable public var cornerRadius: CGFloat = 0.0
    @IBInspectable public var shadowColor: UIColor = UIColor.lightGray
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            addShadow(view: self, shadowColor: shadowColor)
        }
        
    }
    
}
class RoundedImageView: UIImageView {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}


class chatScreenLabel : UILabel {
    @IBInspectable var lblSender : Bool = false
    @IBInspectable var lblReciver : Bool = false
    @IBInspectable var lblHeader : Bool = false
    
    override func awakeFromNib() {
        self.numberOfLines = 0
        if lblSender {
            self.font = CustomFont.PoppinsMedium.returnFont(12)
            self.textColor = UIColor.white
            self.textAlignment = .right
        } else if lblReciver {
            self.font = CustomFont.PoppinsMedium.returnFont(12)
            self.textColor = UIColor.white
            self.textAlignment = .left
        } else if lblHeader {
            self.font = CustomFont.PoppinsMedium.returnFont(9)
            self.textColor = UIColor(hexString: "#ACB1C0")
            self.textAlignment = .center
        }
    }
}


class chatScreenView : UIView {
    
    @IBInspectable var isSenderView : Bool = false
    @IBInspectable var isReciverView : Bool = false
    
    override func awakeFromNib() {
     //   self.roundCorners(corners: [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner], radius: 12)
//        if isSenderView {
//            self.backgroundColor = UIColor(hexString: "#00AA7E")
//        } else if isReciverView {
//            self.backgroundColor = UIColor(hexString: "#DEE2EA")
//        }
    }
    
    override func layoutSubviews() {
    super.layoutSubviews()
        if isSenderView {
            self.backgroundColor = #colorLiteral(red: 0.2145549953, green: 0.2144483924, blue: 0.2096654773, alpha: 1)
            let bounds: CGRect = self.bounds
            let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([ .topLeft, .topRight, .bottomLeft]), cornerRadii: CGSize(width: 18, height: 0.0))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        } else if isReciverView {
            self.backgroundColor = UIColor(hexString: ThemeColor.themeBlue.rawValue)
            let bounds: CGRect = self.bounds
            let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomRight, .topRight]), cornerRadii: CGSize(width: 18.0, height: 0.0))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
        
    }
}

//MARK:- custom chat screen view

class ratingTextview : IQTextView{
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.init(hexString: "#E4E9F2").cgColor
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
        self.textContainerInset = UIEdgeInsets(top: 13, left: 5, bottom: 13, right: 13)
    }
}
