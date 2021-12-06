//
//  BaseVC.swift
//  Gas 2 You
//
//  Created by MacMini on 02/08/21.
//

import Foundation
import UIKit
import SDWebImage
import PDFKit

protocol CompletedTripDelgate {
    func onSaveInvoice()
}

class BaseVC : UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate,SideMenuItemContent {
    
    //MARK:- Properties
    var delegate : CompletedTripDelgate?
    var onTxtBtnPressed: ( (Int) -> () )?
    var pushToRoot = false
    let NavBackButton = UIButton()
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        if pushToRoot {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.PoppinsMedium.returnFont(16)]
    }

    
    //MARK: - download file methods
    func savePdf(urlString:String, fileName:String) {
        if(urlString == ""){
            Utilities.hideHud()
            return
        }
        if(self.pdfFileAlreadySaved(url: urlString, fileName: fileName) == true){
            Utilities.hideHud()
            let vc : WebViewVC = WebViewVC.instantiate(fromAppStoryboard: .Main)
            vc.isLoadFromURL = true
            vc.strUrl = urlString
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }else{
            DispatchQueue.main.async {
                let url = URL(string: urlString)
                let pdfData = try? Data.init(contentsOf: url!)
                let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                let pdfNameFromUrl = "\(AppName)_\(fileName).pdf"
                let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                do {
                    try pdfData?.write(to: actualPath, options: .atomic)
                    self.delegate?.onSaveInvoice()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        Toast.show(title: UrlConstant.Success, message: "Invoice successfully downloaded!", state: .success)
                    }
                } catch {
                    Utilities.showAlertAction(message: "Invoice could not be saved!", vc: self)
                }
                Utilities.hideHud()
            }
        }
    }
    
    func showSavedPdf(url:String, fileName:String) {
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("\(AppName)_\(fileName).pdf".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
                        // its your file! do what you want with it!
                        print(url)
                        
                        let pdfView = PDFView(frame: self.view.bounds)
                        self.view.addSubview(pdfView)
                        pdfView.autoScales = true
                        let fileURL = url
                        pdfView.document = PDFDocument(url: fileURL)
                        
                    }
                }
            } catch {
                print("could not locate Invoice file !!!!!!!")
            }
        }
    }
    
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                let fileName = "\(AppName)_\(fileName).pdf".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                for url in contents {
                    if url.description.contains(fileName) {
                        status = true
                    }
                }
            } catch {
                print("could not locate Invoice file !!!!!!!")
            }
        }
        return status
    }
    
    //MARK:- NavbarrightButton Methods
    func NavbarrightButton() {
        
        let newBackButton = UIBarButtonItem(image: #imageLiteral(resourceName: "IC_chat"), style: .plain, target: self, action: #selector(rightButtonAction(_:)))
        newBackButton.tintColor = .white
        
        let viewFN = UIView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        //        viewFN.backgroundColor = .red
        let button1 = UIButton(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        button1.setImage( #imageLiteral(resourceName: "IC_chat"), for: .normal)
        button1.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        viewFN.addSubview(button1)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        navigationItem.rightBarButtonItem = rightBarButton
        //        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    func NavBarTitle(isOnlyTitle : Bool = true, isMenuButton: Bool = false, title : String, isTitlewhite: Bool = false, controller:UIViewController) {
        
        UIApplication.shared.statusBarStyle =  .default
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        controller.navigationController?.view.backgroundColor = .clear
        controller.navigationController?.navigationBar.isTranslucent = true
        
        controller.navigationController?.navigationBar.barTintColor = colors.white.value;
        controller.navigationController?.navigationBar.tintColor = colors.white.value;
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
        controller.navigationController?.navigationBar.clipsToBounds = false
        if isOnlyTitle {
            //            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.QuicksandBold.returnFont(22.0)]
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 44.0))
            customView.backgroundColor = UIColor.clear
            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 44.0))
            //SJ_Change : was not localize.
            label.text = title
            
            if isTitlewhite {
                label.textColor = UIColor.white
            } else {
                label.textColor = colors.black.value
            }
            
            label.textAlignment = NSTextAlignment.left
            label.backgroundColor = UIColor.clear
            label.font = CustomFont.PoppinsBold.returnFont(16.0)
            customView.addSubview(label)
            
            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton
        }else{
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.PoppinsMedium.returnFont(16.0)]
            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 40 - 40, height: 40.0))
            customView.backgroundColor = UIColor.clear
            
            
            let button = UIButton.init(type: .custom)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
//            button.addShadow(view: button, shadowColor: nil)
            button.NavaddShadow(view: button, shadowColor: nil)
            controller.navigationController?.navigationBar.subviews.forEach {
                    $0.clipsToBounds = false
                }
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            button.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
            
            if isMenuButton {
                button.setImage(#imageLiteral(resourceName: "IC_menu"), for: .normal)
                button.addTarget(self, action: #selector(menuButtonPressed(button:)), for: .touchUpInside)
            } else {
                button.setImage(#imageLiteral(resourceName: "IC_back"), for: .normal)
                
                button.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
            }
            
            
            
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40)) // width: 250
            label.center.x = customView.center.x + 18
            label.center.y = customView.center.y
            label.textAlignment = .center
            
            //SJ_Change :
            label.text = title
            
            if isTitlewhite {
                label.textColor = .white
            } else {
                if #available(iOS 13.0, *) {
                    label.textColor = .label
                } else {
                    label.textColor = .black
                }
            }
            
            label.font = CustomFont.PoppinsBold.returnFont(16)
            customView.addSubview(label)
            customView.addSubview(button)
            
            let leftButton = UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = leftButton
        }
    }
    @objc func menuButtonPressed(button: UIButton) {
        self.showSideMenu()
    }
    @objc func BackButtonWithTitle(button: UIButton) {
        
        if pushToRoot {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    func navBarRightImage(imgURL: String) {
        
        let viewFN = UIView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        let userImage = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        
        userImage.layer.cornerRadius = 0.5 * userImage.bounds.size.width
        userImage.clipsToBounds = true
        userImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        userImage.sd_setBackgroundImage(with: URL(string:imgURL), for: .normal, placeholderImage: UIImage(named: "dummy_user"), options: [.continueInBackground, .refreshCached])
        userImage.isUserInteractionEnabled = false
        viewFN.addSubview(userImage)
        
        let rightBarButton = UIBarButtonItem(customView: viewFN)
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func rightButtonAction(_ sender: UIBarButtonItem?) {
        
        
    }
    func setNavigationBarInViewController (controller : UIViewController,naviColor : UIColor, naviTitle : String, leftImage : String , rightImages : [String], isTranslucent : Bool, ShowShadow:Bool? = false, iswhiteTitle : Bool = false)
    {
        UIApplication.shared.statusBarStyle = .default
        controller.navigationController?.isNavigationBarHidden = false
        controller.navigationController?.navigationBar.isOpaque = false;
        
        controller.navigationController?.navigationBar.isTranslucent = isTranslucent
        
        controller.navigationController?.navigationBar.barTintColor = naviColor;
        controller.navigationController?.navigationBar.tintColor = .clear
        controller.navigationController?.navigationBar.backgroundColor = .clear
        controller.navigationController?.navigationBar.clipsToBounds = true
        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationController?.navigationBar.shadowImage = UIImage()
      
        if naviTitle == "" {
            controller.navigationItem.titleView = UIView()
        } else {
            let lblNavTitle = UILabel()
            lblNavTitle.font = ATFontManager.setFont(18, andFontName: FontName.bold.rawValue)
            lblNavTitle.backgroundColor = UIColor.clear
            lblNavTitle.textColor =  iswhiteTitle ? .white : colors.black.value
            lblNavTitle.numberOfLines = 0
            lblNavTitle.text = naviTitle

         
            self.navigationItem.titleView = lblNavTitle
           
        }
            if leftImage != "" {
                if leftImage == "Back" {
                    
                    NavBackButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                   // let btnLeft = UIButton(frame: )
                    NavBackButton.setImage(UIImage.init(named: "IC_back"), for: .normal)
                    NavBackButton.layer.setValue(controller, forKey: "controller")
                    NavBackButton.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
                    let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    LeftView.addSubview(NavBackButton)
                    LeftView.backgroundColor = .white
                    addNormalShaddow(view: LeftView)
                    LeftView.layer.cornerRadius = 9
                    LeftView.NavaddShadow(view: LeftView, shadowColor: nil)
                    NavBackButton.isExclusiveTouch = true
                    NavBackButton.isMultipleTouchEnabled = false
                    let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                    btnLeftBar.style = .plain
                    controller.navigationItem.leftBarButtonItem = btnLeftBar
                } else if leftImage == "Menu" {
                    let MenuButton = UIButton()
                    MenuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                   // let btnLeft = UIButton(frame: )
                    MenuButton.setImage(UIImage.init(named: "ic_menu"), for: .normal)
                    MenuButton.layer.setValue(controller, forKey: "controller")
                    MenuButton.addTarget(self, action: #selector(menuButtonPressed(button:)), for: .touchUpInside)
                    MenuButton.NavaddShadow(view: MenuButton, shadowColor: nil)
                    let LeftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                    LeftView.addSubview(MenuButton)
                    MenuButton.isExclusiveTouch = true
                    MenuButton.isMultipleTouchEnabled = false
                    let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: LeftView)
                    btnLeftBar.style = .plain
                    controller.navigationItem.leftBarButtonItem = btnLeftBar
                }
            } else {
                let emptyView = UIView()
                let btnLeftBar : UIBarButtonItem = UIBarButtonItem.init(customView: emptyView)
                btnLeftBar.style = .plain
                controller.navigationItem.leftBarButtonItem = btnLeftBar
            }
           
            if rightImages.count != 0 {
                var arrButtons = [UIBarButtonItem]()
                rightImages.forEach { (title) in
                    
                   
                }
                controller.navigationItem.rightBarButtonItems = arrButtons
            }
        
    }
    
    
    
//    func NavBarTitle(isOnlyTitle : Bool = true, isMenuButton: Bool = false, title : String, controller:UIViewController) {
//        
//        UIApplication.shared.statusBarStyle = .lightContent
//        controller.navigationController?.isNavigationBarHidden = false
//        controller.navigationController?.navigationBar.isOpaque = false;
//        controller.navigationController?.view.backgroundColor = .clear
//        controller.navigationController?.navigationBar.isTranslucent = true
//        
//        controller.navigationController?.navigationBar.barTintColor = colors.white.value;
//        controller.navigationController?.navigationBar.tintColor = colors.white.value;
//        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        controller.navigationController?.navigationBar.shadowImage = UIImage()
//        
//        if isOnlyTitle {
//            //            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.QuicksandBold.returnFont(22.0)]
//            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 44.0))
//            customView.backgroundColor = UIColor.clear
//            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 44.0))
//            //SJ_Change : was not localize.
//            label.text = title
//            label.textColor = colors.black.value
//            label.textAlignment = NSTextAlignment.left
//            label.backgroundColor = UIColor.clear
//            label.font = CustomFont.PoppinsMedium.returnFont(16.0)
//            customView.addSubview(label)
//            
//            let leftButton = UIBarButtonItem(customView: customView)
//            self.navigationItem.leftBarButtonItem = leftButton
//        }else{
//            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.PoppinsMedium.returnFont(16.0)]
//            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 40 - 40, height: 40.0))
//            customView.backgroundColor = UIColor.clear
//            
//            
//            let button = UIButton.init(type: .custom)
//            button.backgroundColor = .white
//            button.layer.cornerRadius = 10
//            button.addShadow(view: button, shadowColor: nil)
//            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            button.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
//            
//            if isMenuButton {
//                button.setImage(#imageLiteral(resourceName: "IC_menu"), for: .normal)
//                button.addTarget(self, action: #selector(menuButtonPressed(button:)), for: .touchUpInside)
//            } else {
//                button.setImage(#imageLiteral(resourceName: "IC_back"), for: .normal)
//                button.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
//            }
//            
//            
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40)) // width: 250
//            label.center.x = customView.center.x + 18
//            label.center.y = customView.center.y
//            label.textAlignment = .center
//            
//            //SJ_Change :
//            label.text = title
//            label.textColor = .label
//            label.font = CustomFont.PoppinsMedium.returnFont(16)
//            customView.addSubview(label)
//            customView.addSubview(button)
//            
//            let leftButton = UIBarButtonItem(customView: customView)
//            self.navigationItem.leftBarButtonItem = leftButton
//        }
//    }
    
    
    
    /*  func NavBarTitle(isOnlyTitle : Bool = true, isMenuButton: Bool = false,title : String, controller:UIViewController) {
     
     UIApplication.shared.statusBarStyle = .lightContent
     controller.navigationController?.isNavigationBarHidden = false
     controller.navigationController?.navigationBar.isOpaque = false;
     controller.navigationController?.view.backgroundColor = .clear
     controller.navigationController?.navigationBar.isTranslucent = true
     
     controller.navigationController?.navigationBar.barTintColor = colors
     .value;
     controller.navigationController?.navigationBar.tintColor = colors.white.value;
     controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
     controller.navigationController?.navigationBar.shadowImage = UIImage()
     
     if isOnlyTitle {
     //            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.QuicksandBold.returnFont(22.0)]
     let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 48.0))
     customView.backgroundColor = UIColor.clear
     let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 48.0))
     //SJ_Change : was not localize.
     label.text = title
     label.textColor = colors.black.value
     label.textAlignment = NSTextAlignment.left
     label.backgroundColor = UIColor.clear
     label.font = CustomFont.PoppinsMedium.returnFont(16)
     customView.addSubview(label)
     
     let leftButton = UIBarButtonItem(customView: customView)
     self.navigationItem.leftBarButtonItem = leftButton
     }else{
     self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.PoppinsMedium.returnFont(16)]
     let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 40 - 40, height: 500))
     customView.backgroundColor = UIColor.yellow
     
     let button = UIButton.init(type: .custom)
     button.setImage(#imageLiteral(resourceName: "IC_menu"), for: .normal)
     button.backgroundColor = .white
     button.layer.cornerRadius = 10
     button.addShadow(view: button, shadowColor: nil)
     
     //            button.imageView?.contentMode =
     button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     button.frame = CGRect(x: 6.0, y: 0.0, width: 48.0, height: 48.0)
     
     if isMenuButton {
     button.addTarget(self, action: #selector(menuButtonPressed(button:)), for: .touchUpInside)
     } else {
     button.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
     }
     
     let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40)) // width: 250
     label.center.x = customView.center.x + 18
     label.center.y = customView.center.y
     label.textAlignment = .center
     //            label.backgroundColor = .purple
     
     
     //SJ_Change :
     label.text = title
     label.textColor = .label
     label.font = CustomFont.PoppinsMedium.returnFont(16)
     customView.addSubview(label)
     customView.addSubview(button)
     
     let leftButton = UIBarButtonItem(customView: customView)
     self.navigationItem.leftBarButtonItem = leftButton
     }
     }
     */
    
    //    func NavBarTitle(isOnlyTitle : Bool = true, title : String, controller:UIViewController) {
    //
    //        UIApplication.shared.statusBarStyle = .lightContent
    //        controller.navigationController?.isNavigationBarHidden = false
    //        controller.navigationController?.navigationBar.isOpaque = false;
    //        controller.navigationController?.view.backgroundColor = .clear
    //        controller.navigationController?.navigationBar.isTranslucent = true
    //
    //        controller.navigationController?.navigationBar.barTintColor = colors.white.value;
    //        controller.navigationController?.navigationBar.tintColor = colors.white.value;
    //        controller.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    //        controller.navigationController?.navigationBar.shadowImage = UIImage()
    //
    //        if isOnlyTitle {
    ////            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.QuicksandBold.returnFont(22.0)]
    //            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 44.0))
    //            customView.backgroundColor = UIColor.clear
    //            let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 44.0))
    //            //SJ_Change : was not localize.
    //            label.text = title
    //            label.textColor = colors.black.value
    //            label.textAlignment = NSTextAlignment.left
    //            label.backgroundColor = UIColor.clear
    //            label.font = CustomFont.PoppinsMedium.returnFont(16)
    //            customView.addSubview(label)
    //
    //            let leftButton = UIBarButtonItem(customView: customView)
    //            self.navigationItem.leftBarButtonItem = leftButton
    //        }else{
    //            self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: CustomFont.PoppinsMedium.returnFont(16)]
    //            let customView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width - 40 - 40, height: 48))
    //            customView.backgroundColor = UIColor.clear
    //
    //            let button = UIButton.init(type: .custom)
    //            button.setImage(#imageLiteral(resourceName: "IC_menu"), for: .normal)
    //            button.backgroundColor = .white
    //            button.layer.cornerRadius = 10
    //            button.addShadow(view: button, shadowColor: nil)
    //
    ////            button.imageView?.contentMode =
    //            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //            button.frame = CGRect(x: 6.0, y: 0.0, width: 48.0, height: 48.0)
    //            button.addTarget(self, action: #selector(BackButtonWithTitle(button:)), for: .touchUpInside)
    //
    //            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 40)) // width: 250
    //            label.center.x = customView.center.x + 18
    //            label.center.y = customView.center.y
    //            label.textAlignment = .center
    ////            label.backgroundColor = .purple
    //
    //
    //            //SJ_Change :
    //            label.text = title
    //            label.textColor = .label
    //            label.font = CustomFont.PoppinsMedium.returnFont(16)
    //            customView.addSubview(label)
    //            customView.addSubview(button)
    //
    //            let leftButton = UIBarButtonItem(customView: customView)
    //            self.navigationItem.leftBarButtonItem = leftButton
    //        }
    //    }
    
   
    func addNormalShaddow(view:UIView) {
        
//        let shadowPath = UIBezierPath(rect: self.bounds)
//        self.layer.shadowRadius = self.frame.height/2
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
//        self.layer.shadowOpacity = 0.4
//        self.layer.shadowPath = shadowPath.cgPath

        /* let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.2
        // self.layer.shadowRadius =
        self.layer.shadowPath = shadowPath.cgPath
        */
        view.layer.masksToBounds = false
        view.layer.shadowRadius = view.frame.height/2
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 3.0
        
    }
   
    
    //    func textfieldRightbtnsecurePassword(image : UIImage){
    //        UITextField.rightViewMode = .always
    //        txtCinfirmPassword.rightViewMode = UITextField.ViewMode.always
    //        txtNewPassword.rightViewMode = .always
    //        txtNewPassword.rightViewMode = UITextField.ViewMode.always
    //        txtCurrentPassword.rightViewMode = .always
    //        txtCurrentPassword.rightViewMode = UITextField.ViewMode.always
    //        let vwRight1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: txtNewPassword.frame.height))
    //        let vwRight2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: txtCurrentPassword.frame.height))
    //        let vwRight3 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: txtCinfirmPassword.frame.height))
    //        let frame =  CGRect(x: 0, y: 0, width: 50, height: vwRight1.frame.height)
    //
    //        let button = UIButton(frame: frame)
    //        let button1 = UIButton(frame: frame)
    //        let button2 = UIButton(frame: frame)
    ////         let image1 = UIImage(named: "imgVisiblePw")
    //        button.setImage(image, for: .normal)
    //        button.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
    //        button1.setImage(image, for: .normal)
    //        button1.addTarget(self, action: #selector(iconAction1(sender:)), for: .touchUpInside)
    //        button2.setImage(image, for: .normal)
    //        button2.addTarget(self, action: #selector(iconAction2(sender:)), for: .touchUpInside)
    //        button.imageView?.contentMode = .scaleAspectFit
    //        button1.imageView?.contentMode = .scaleAspectFit
    //        button2.imageView?.contentMode = .scaleAspectFit
    //         vwRight1.addSubview(button)
    //        vwRight2.addSubview(button1)
    //        vwRight3.addSubview(button2)
    //        txtCinfirmPassword.rightView = vwRight3
    //        txtNewPassword.rightView = vwRight1
    //        txtCurrentPassword.rightView = vwRight2
    ////         imageView1.contentMode = .scaleAspectFit
    //    }
    
    func textfieldRightbtn(image : UIImage, textfield : UITextField) {
        textfield.rightViewMode = .always
        let vwRight = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textfield.frame.height))
        
        let frame =  CGRect(x: 0, y: 10, width: 30, height: vwRight.frame.height - 10)
        
        let button = UIButton(frame: frame)
        //         let image1 = UIImage(named: "imgVisiblePw")
        button.setImage(image, for: .normal)
        button.tag = textfield.tag
        button.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        //        button.isUserInteractionEnabled = true
        vwRight.addSubview(button)
        textfield.rightView = vwRight
        //         imageView1.contentMode = .scaleAspectFit
        
    }
    
    //    func textfieldLeftView(image: UIImage, textfield: UITextField) {
    //        textfield.leftViewMode = .always
    //
    //        (textfield as? themeTextField)?.titleLabel.textAlignment = .right
    //        (textfield as? themeTextField)?.textAlignment = .center
    //
    //        let vwleft = UIView(frame: CGRect(x: 0, y: 40, width: 80, height: textfield.frame.height))
    //
    //        let frameForDropDownBtn =  CGRect(x: 50, y: 0, width: 30, height: vwleft.frame.height)
    //        let button = UIButton(frame: frameForDropDownBtn)
    ////         let image1 = UIImage(named: "imgVisiblePw")
    //        button.setImage(image, for: .normal)
    //
    //        button.addTarget(self, action: #selector(iconAction(sender:)), for: .touchUpInside)
    //        button.imageView?.contentMode = .scaleAspectFit
    //
    //
    //        let frameForCodeTxtfield = CGRect(x: 0, y: 0, width: 50, height: vwleft.frame.height)
    //        let txtfield = UITextField(frame: frameForCodeTxtfield)
    //        txtfield.text = "+54"
    //        txtfield.borderStyle = .none
    //        textfield.tag = 3
    //        button.tag = textfield.tag
    //        txtfield.addSubview(button)
    //
    //        vwleft.addSubview(txtfield)
    //        textfield.leftView = vwleft
    //
    //    }
    
    @objc func iconAction(sender: UIButton){
        self.onTxtBtnPressed!(sender.tag)
    }
    
}
//extension UITextField {
//func setIcon(_ image: UIImage) {
//   let iconView = UIImageView(frame:
//                  CGRect(x: 10, y: 5, width: 20, height: 20))
//   iconView.image = image
//   let iconContainerView: UIView = UIView(frame:
//                  CGRect(x: 20, y: 0, width: 30, height: 30))
//   iconContainerView.addSubview(iconView)
//   leftView = iconContainerView
//   leftViewMode = .always
//}
//}
