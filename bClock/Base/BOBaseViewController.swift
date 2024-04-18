//
//  BOBaseViewController.swift
//  bClock
//
//  Created by bobo on 2024/3/11.
//

import UIKit

class BOBaseViewController: UIViewController {
    
    ///子类可直接覆盖deinit方法
    deinit {
        debugPrint(String(describing: type(of: self))+" deinit")
    }
    
    var rightItemButton: UIButton?
    var leftItemButton: UIButton?
    
    /// 是否隐藏导航栏分割线
    var isHiddenNavigationBarBottomLine = false {
        didSet {
            let navVC = (self.navigationController as! BONavigationController)
            navVC.bottomLine?.isHidden = isHiddenNavigationBarBottomLine
        }
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        navigationController?.setNaviagtionBackgroundColor(color: UIColor.black)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willTerminate), name: UIApplication.willTerminateNotification, object: nil)
        
    }
    
    /// App由后台进入前台
    @objc func willEnterForeground() {
//        NSLog("willEnterForeground")
    }
    /// App变为活跃
    @objc func didBecomeActive() {
//        NSLog("didBecomeActive")
    }
    /// App将变为为活跃状态
    @objc func willResignActive() {
//        NSLog("willResignActive")
    }
    /// App进入后台
    @objc func didEnterBackground() {
//        NSLog("didEnterBackground")
    }
    ///  App被杀死
    @objc func willTerminate() {
//        NSLog("willTerminate")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*********************导航栏方法**********************************/
    /******  左  ******/
    final func setNavItemLeftNil() {
        self.navigationItem.leftBarButtonItem = nil
    }
    final func setNavItemLeftLable(text: String, textColor: UIColor = AppColor.PlacedColor, textFont: UIFont? = kRegularFont(16)) {
        let leftBtn = UIButton.init(titleColor: textColor, font: textFont, title: text)
        leftBtn.frame = .init(x: 0, y: 0, width: 46*pt, height: 40)
        leftBtn.addTarget(self, action: #selector(BOBaseViewController.leftBarAction), for: .touchUpInside)
        let leftItem = UIBarButtonItem.init(customView: leftBtn)
        leftItemButton = leftBtn
        self.navigationItem.leftBarButtonItem = leftItem
    }
    ///图片原始大小
    final func setNavItemLeftImage(name:String) {
        let image = UIImage(named:name)
        if image != nil {
            setNavItemLeftImage_CustomFrame(name:name, frame: CGRect.init(origin: .zero, size: image!.size))
        }
    }
    /// 默认frame:(x: 0, y: 0, width: 20, height: 20)
    final func setNavItemLeftImage_DefaultFrame(name:String) {
        setNavItemLeftImage_CustomFrame(name: name, frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    final func setNavItemLeftImage_CustomFrame(name:String, frame:CGRect) {
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = frame
        leftBtn.addTarget(self, action: #selector(BOBaseViewController.leftBarAction), for: .touchUpInside)
        leftBtn.setImage(UIImage(named:name), for: .normal)
        leftBtn.setImage(UIImage(named:name), for: .highlighted)
        let leftBarItem = UIBarButtonItem(customView: leftBtn)
        leftItemButton = leftBtn
        self.navigationItem.leftBarButtonItem = leftBarItem
    }

    
    /******  右  ******/
    final func setNavItemRightNil() {
        self.navigationItem.rightBarButtonItem = nil
    }
    final func setNavRightLabel(text: String, textColor: UIColor = AppColor.PlacedColor, textFont: UIFont? = kRegularFont(16)) {
        let rightBtn = UIButton.init(titleColor: textColor, font: textFont, title: text)
        rightBtn.frame = .init(x: 0, y: 0, width: 46*pt, height: 40)
        rightBtn.addTarget(self, action: #selector(BOBaseViewController.rightBarAction), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        rightItemButton = rightBtn
        self.navigationItem.rightBarButtonItem = rightItem
    }
    ///图片原始大小
    final func setNavItemRightImage(name:String) {
        let image = UIImage(named:name)
        if image != nil {
            setNavItemRightImage_CustomFrame(name:name, frame: CGRect.init(origin: .zero, size: image!.size))
        }
    }
    /// 默认frame:(x: 0, y: 0, width: 20, height: 20)
    final func setNavItemRightImage_DefaultFrame(name:String) {
        setNavItemRightImage_CustomFrame(name: name, frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    final func setNavItemRightImage_CustomFrame(name:String, frame:CGRect) {
        let imgName = name
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.frame = frame
        rightBtn.addTarget(self, action: #selector(BOBaseViewController.rightBarAction), for: .touchUpInside)
        rightBtn.setImage(UIImage(named:imgName), for: .normal)
        let rightBarItem = UIBarButtonItem(customView: rightBtn)
        rightItemButton = rightBtn
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    /// 右导航自定义视图
    /// - Parameter view: 自定义视图(实际是个UIButton)
    final func setNavItemRightCustomView(view: UIButton) {
        let rightBarItem = UIBarButtonItem(customView: view)
        rightItemButton = view
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
    
    /// 图片文字
    final func setNavRightImageLabel(text: String,
                                     textColor: UIColor = AppColor.PlacedColor,
                                     textFont: UIFont? = kRegularFont(16),
                                     imageName: String,
                                     backgroundColor: UIColor = AppColor.WhiteBlueColor,
                                     cornerRadius: CGFloat? = nil) {
        let textWidth = UIView.getLabelWidth(byTitle: text, font: textFont, space: 30)
        let rightBtn = UIButton.init(titleColor: textColor, font: textFont, title: text)
        rightBtn.frame = .init(x: 0, y: 0, width: textWidth, height: 24)
        rightBtn.setImage(UIImage(named: imageName), for: UIControl.State())
        rightBtn.addTarget(self, action: #selector(BOBaseViewController.rightBarAction), for: .touchUpInside)
        if let value = cornerRadius {
            rightBtn.cornerRadius = value
        }
        rightBtn.backgroundColor = backgroundColor
        rightBtn.imagePosition(style: .right, spacing: 0)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        rightItemButton = rightBtn
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    /******  中  ******/
    ///label原始大小
    final func setNavMidLabel(text:String, textColor:UIColor? = .black, textFont:UIFont = kMediumFont(17)) {
        let labelText = text
        let titleLabel = UILabel()
        titleLabel.text = labelText
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = textColor
        titleLabel.font = textFont
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    ///默认frame:(x: 120, y: 12, width: 80, height: 20)
    final func setNavMidLabel_DefaultFrame(text:String, frame:CGRect) {
        setNavItemRightImage_CustomFrame(name: text, frame: CGRect(x: 120, y: 12, width: 80, height: 20))
    }
    final func setNavMidLabel_CustomFrame(text:String, frame:CGRect) {
        let labelText = text
        let titleLabel = UILabel.init(frame: frame)
        titleLabel.text = labelText
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
    }
    
    final func setNavItemMidImage(name:String) {
        let image = UIImage(named:name)
        if image != nil {
            setNavItemMidImage_CustomFrame(name: name, frame: CGRect.init(origin: .zero, size: image!.size))
        }
    }
    //默认frame:(x: 0, y: 0, width: 84, height: 35)
    final func setNavItemMidImage_DefaultFrame(name:String){
        setNavItemMidImage_CustomFrame(name: name, frame: CGRect(x: 0, y: 0, width: 84, height: 35))
    }
    final func setNavItemMidImage_CustomFrame(name:String, frame:CGRect) {
        let imageView = UIImageView(frame:frame)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: name)
        imageView.backgroundColor = UIColor.clear
        self.navigationItem.titleView = imageView
    }
    // 导航栏背景图
    final func setNavItemBackgroundImage(name:String? = nil ,isHiddenBottomLine:Bool = false){
        var image:UIImage?
        if let name = name {
            image = UIImage.init(named: name)!
            image = image?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: UIImage.ResizingMode.stretch)
        } else {
            image = nil
        }
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
    // 导航栏Item tintColor
    final func setNavItemTintColor(color:UIColor) {
        self.navigationController?.navigationBar.tintColor = color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
    
    ///点击左按钮方法
    @objc func leftBarAction() {
        
        guard let navigationController = self.navigationController else { return }
        
        if self.presentingViewController != nil {
            if navigationController.viewControllers.count == 1 {
                self.dismiss(animated: true, completion: nil)
            } else {
                navigationController.popViewController(animated: true)
            }
        } else {
            if navigationController.viewControllers.count > 1 {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
   
    
    ///点击右按钮方法
    @objc func rightBarAction() {}
}
