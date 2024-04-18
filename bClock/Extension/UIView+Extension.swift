//
//  UIView+Extension.swift
//  EPorts
//
//  Created by e-ports on 2022/1/11.
//

import Foundation
import UIKit




extension UIView {
    ///获取view所属的控制器
    var ownerViewController_byRecursion:UIViewController? {
        get {
            guard let nextResponder = self.next else {return nil}
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            } else if nextResponder is UIView {
                return (nextResponder as! UIView).ownerViewController
            }
            return nil
        }
    }
    
    var ownerViewController:UIViewController? {
        get {
            var nextResponder = self.next
            while nextResponder != nil {
                if nextResponder is UIViewController {
                    return nextResponder as? UIViewController
                } else if nextResponder is UIView {
                    nextResponder = nextResponder?.next
                }
            }
            return nil
        }
    }
}


extension UIView {
    
    func fadeHide() {
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.alpha = 0
        }
    }
    
    func fadeShow() {
        UIView.animate(withDuration: 0.2) {[weak self] in
            self?.alpha = 1
        }
    }
    
    // MARK: - 设置圆角
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    // MARK: - 设置描边
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    // MARK: - 设置描边的颜色
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // 找到view所在的当前控制器
    func findController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    
    func findNavigator() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        
        return nil
    }

    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    /**  顶部  */
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
    }
    
    /**  底部  */
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue - self.frame.size.height
            self.frame = frame
        }
    }
    
    /**  左边  */
    public var left: CGFloat
    {
        get {
            return self.frame.origin.x
        }
        
        set {
            
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
        
    }
    
    /**  右边  */
    public var right:CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue - self.frame.size.width
            self.frame = frame
        }
        
    }
    
    public var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    public var centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    /// Size of view.
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.width = newValue.width
            self.height = newValue.height
        }
    }
    
    /// Width of view.
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    /// Height of view.
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    public var frameInScreen: CGRect {
        return CGRect(x: positionInScreen.x, y: positionInScreen.y, width: width, height: height)
    }
    
    public var positionInScreen: CGPoint {
        /// 先判断是否有父视图，如果没有父视图，直接返回视图的位置就行
        guard let superview = superview else { return frame.origin }
        
        if let scrollView = superview as? UIScrollView {
            let position = CGPoint(x: x, y: y)
            let superPosition = superview.positionInScreen
            let scrollViewOffset = scrollView.contentOffset
            return CGPoint(x: superPosition.x + position.x - scrollViewOffset.x , y: superPosition.y + position.y - scrollViewOffset.y)
        } else {
            let position = self.frame.origin
            let superPosition = superview.positionInScreen
            return CGPoint(x: superPosition.x + position.x, y: superPosition.y + position.y)
        }
    }
    
//    public var snapImage: UIImage? {
//        let size = bounds.size
//        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
//        if let currentContext = UIGraphicsGetCurrentContext() {
//            layer.render(in: currentContext)
//        }
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//
//        return image
//    }
    
    /// Search up the view hierarchy of the table view cell to find the containing table view cell
//    public var tableViewCell: UITableViewCell? {
//        get {
//            var cell: UIView? = superview
//            while !(cell is UITableViewCell) && cell != nil {
//                cell = cell?.superview
//            }
//            return cell as? UITableViewCell
//        }
//    }
    
    /// Search up UICollectionViewCell
//    public var collectionViewCell: UICollectionViewCell? {
//        get {
//            var cell: UIView? = superview
//            while !(cell is UICollectionViewCell) && cell != nil {
//                cell = cell?.superview
//            }
//            return cell as? UICollectionViewCell
//        }
//    }
    
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview.flatMap { $0.superview(of: T.self) }
    }
    
    /// This is the function to get subViews of a view of a particular type
    /// https://stackoverflow.com/a/45297466/5321670
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    /// 移除所有子视图
    func removeAllSubViews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// 当前view所在的UIViewController
    func viewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        
        return nil
    }
    
    /// 设置固有大小，内容不拉伸也不压缩
    func setIntrinsicSize() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    /// 阴影
    ///
    /// - Parameters:
    ///   - shadowRadius: 阴影模糊度
    ///   - shadowOpacity: 阴影透明底
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 阴影偏移量
    func shadowCorner(shadowRadius: CGFloat = 2*pt,
                      shadowOpacity: Float = 0.1,
                      shadowColor: UIColor = UIColor.init("#111111"),
                      shadowOffset: CGSize = CGSize(width: 0, height: pt)) {
        // 设置阴影的同时设置圆角（注意一定要有frame才生效）
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        
        // 设置缓存、抗锯齿边缘
        layer.shouldRasterize = true
        contentScaleFactor = UIScreen.main.scale
        layoutIfNeeded()
        layer.cornerRadius = shadowRadius/2
    }
    
    /// 添加阴影
    ///
    /// - Parameters:
    ///   - shadowColor: 颜色
    ///   - opacity: 透明度
    ///   - radius: 半径
    ///   - offset: 偏移量
    func df_shadow(_ shadowColor: UIColor?, opacity: CGFloat, radius: CGFloat, offset: CGSize) {
        //给Cell设置阴影效果
        layer.masksToBounds = false
        if let aColor = shadowColor?.cgColor {
            layer.shadowColor = aColor
        }
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    /// 任意圆角
    ///
    /// - Parameters:
    ///   - cornerRadius: 半径
    ///   - rectCorner: 圆角位置
    ///   - needBounds: bounds
    func df_round(_ cornerRadius: CGFloat, rectCorners rectCorner: UIRectCorner, needBounds: CGRect) {
        
        let maskPath = UIBezierPath(roundedRect: needBounds, byRoundingCorners: rectCorner, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

private var gradientLayerStr: Void?
// MARK: - 渐变色
extension UIView {
    
    //枚举渐变色的方向
    enum GradientDirection {
        case Horizontal
        case Vertical
        case Right
        case Left
        case Bottom
        case Top
        case TopLeftToBottomRight
        case TopRightToBottomLeft
        case BottomLeftToTopRight
        case BottomRightToTopLeft
    }
    
    @discardableResult
    func setGradient(colors: [UIColor], direction:GradientDirection) -> CAGradientLayer {
        func setGradient(_ layer: CAGradientLayer) {
            self.layoutIfNeeded()
            var colorArr = [CGColor]()
            for color in colors {
                colorArr.append(color.cgColor)
            }
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.frame = self.bounds
            CATransaction.commit()
            
            layer.colors = colorArr
            layer.locations = [0.0, 1.0]
            
            switch direction {
            case .Horizontal:
                layer.startPoint = CGPoint(x:0.0, y:0.0)
                layer.endPoint = CGPoint(x:1.0, y:0.0)
                
            case .Vertical:
                layer.startPoint = CGPoint(x:0.0, y:0.0)
                layer.endPoint = CGPoint(x:0.0, y:1.0)
                
            case .Right:
                layer.startPoint = CGPoint(x:0.0, y:0.5)
                layer.endPoint = CGPoint(x:1.0, y:0.5)
                
            case .Left:
                layer.startPoint = CGPoint(x:1.0, y:0.5)
                layer.endPoint = CGPoint(x:0.0, y:0.5)
                
            case .Bottom:
                layer.startPoint = CGPoint(x:0.5, y:0.0)
                layer.endPoint = CGPoint(x:0.5, y:1.0)
                
            case .Top:
                layer.startPoint = CGPoint(x:0.5, y:1.0)
                layer.endPoint = CGPoint(x:0.5, y:0.0)
                
            case .TopLeftToBottomRight:
                layer.startPoint = CGPoint(x:0.0, y:0.0)
                layer.endPoint = CGPoint(x:1.0, y:1.0)
                
            case .TopRightToBottomLeft:
                layer.startPoint = CGPoint(x:1.0, y:0.0)
                layer.endPoint = CGPoint(x:0.0, y:1.0)
                
            case .BottomLeftToTopRight:
                layer.startPoint = CGPoint(x:0.0, y:1.0)
                layer.endPoint = CGPoint(x:1.0, y:0.0)
                
            default:
                layer.startPoint = CGPoint(x:1.0, y:1.0)
                layer.endPoint = CGPoint(x:0.0, y:0.0)
            }
        }
        
        if let gradientLayer = objc_getAssociatedObject(self, &gradientLayerStr) as? CAGradientLayer {
            setGradient(gradientLayer)
            return gradientLayer
        }else {
            let gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer , at: 0)
            setGradient(gradientLayer)
            objc_setAssociatedObject(self, &gradientLayerStr, gradientLayer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return gradientLayer
        }
    }
}

protocol UIViewProtocol {
    
}
extension UIViewProtocol {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    static func loadFromNibs(_ nibname : String? = nil,index:Int) -> AnyObject {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?[index] as AnyObject
    }
}

// MARK: - 获取宽高
extension UIView {
    
    /// get label's Height
    ///
    /// - Parameters:
    ///   - width: label's width
    ///   - title: content
    ///   - font: label's font
    /// - Returns: Height
    class func getLabelHeight(byWidth width: CGFloat, title: String?, font: UIFont?) -> CGFloat {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        label.text = title
        if let aFont = font {
            label.font = aFont
        }
        label.numberOfLines = 0
        label.sizeToFit()
        let height: CGFloat = label.frame.size.height
        return height
    }
    
    /// get label's Width
    ///
    /// - Parameters:
    ///   - title: content
    ///   - font: label's font
    ///   - space: space
    /// - Returns: Width
    class func getLabelWidth(byTitle title: String?, font: UIFont?, space: CGFloat) -> CGFloat {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = title
        if let aFont = font {
            label.font = aFont
        }
        label.numberOfLines = 1
        label.sizeToFit()
        let width: CGFloat = label.frame.size.width + space
        return width
    }
}
// MARK:- 关于UIView的 圆角、阴影、边框 的设置
public extension UIView {
    // MARK: 5.1、添加圆角
    /// 添加圆角
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角的大小
    func addCorner(conrners: UIRectCorner , radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    // MARK: 5.2、给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 设置阴影颜色
        layer.shadowColor = shadowColor.cgColor
        // 设置透明度
        layer.shadowOpacity = shadowOpacity
        // 设置阴影半径
        layer.shadowRadius = shadowRadius
        // 设置阴影偏移量
        layer.shadowOffset = shadowOffset
    }
    // MARK: 5.3、添加阴影和圆角并存
    /// 添加阴影和圆角并存
    /// - Parameters:
    ///   - conrners: 具体哪个圆角
    ///   - radius: 圆角大小
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移]);
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addCornerAndShadow(superview: UIView, conrners: UIRectCorner , radius: CGFloat = 3, shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
    
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    
        let subLayer = CALayer()
        let fixframe = self.frame
        subLayer.frame = fixframe
        subLayer.cornerRadius = shadowRadius
        subLayer.backgroundColor = shadowColor.cgColor
        subLayer.masksToBounds = false
        // shadowColor阴影颜色
        subLayer.shadowColor = shadowColor.cgColor
        // shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOffset = shadowOffset
        // 阴影透明度，默认0
        subLayer.shadowOpacity = shadowOpacity
        // 阴影半径，默认3
        subLayer.shadowRadius = shadowRadius
        superview.layer.insertSublayer(subLayer, below: self.layer)
    }
    // MARK: 5.4、添加边框
    /// 添加边框
    /// - Parameters:
    ///   - width: 边框宽度
    ///   - color: 边框颜色
    func addBorder(borderWidth: CGFloat, borderColor: UIColor) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    // MARK: 5.5、添加顶部的 边框
    /// 添加顶部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderTop(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: borderWidth, color: borderColor)
    }
    // MARK: 5.6、添加顶部的 内边框
    /// 添加顶部的 内边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    ///   - padding: 边框距离边上的距离
    func addBorderTopWithPadding(borderWidth: CGFloat, borderColor: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: borderWidth, color: borderColor)
    }
    // MARK: 5.7、添加底部的 边框
    /// 添加底部的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderBottom(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth, color: borderColor)
    }
    // MARK: 5.8、添加左边的 边框
    /// 添加左边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderLeft(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: 0, y: 0, width: borderWidth, height: frame.height, color: borderColor)
    }
    // MARK: 5.9、添加右边的 边框
    /// 添加右边的 边框
    /// - Parameters:
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    func addBorderRight(borderWidth: CGFloat, borderColor: UIColor) {
        addBorderUtility(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height, color: borderColor)
    }
    // MARK:- 5.10、画圆环
    /// 画圆环
    /// - Parameters:
    ///   - fillColor: 内环的颜色
    ///   - strokeColor: 外环的颜色
    ///   - strokeWidth: 外环的宽度
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let ciecleRadius = self.width > self.height ? self.height : self.width
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: ciecleRadius, height: ciecleRadius), cornerRadius: ciecleRadius / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
}
extension UIView {
    /// 边框的私有内容
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
}
// MARK: 批量增加子视图
extension UIView {
    /// 添加子视图
    ///
    /// - Parameter dic: 子视图字典
    func myAddSubViews(_ dictionary: [String: UIView]){
        for (_,view) in dictionary {
            self.addSubview(view)
        }
    }
}

// 虚线
extension UIView{
    
    func swiftDrawBoardDottedLine (width:CGFloat,lenth:CGFloat,space:CGFloat,cornerRadius:CGFloat,color:UIColor) {
        self.layer.cornerRadius = cornerRadius
        let borderLayer =  CAShapeLayer()
        borderLayer.bounds = self.bounds
        
        borderLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY);
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: cornerRadius).cgPath
        borderLayer.lineWidth = width / UIScreen.main.scale
        
        //虚线边框---小边框的长度
        
        borderLayer.lineDashPattern = [lenth,space] as? [NSNumber] //前边是虚线的长度，后边是虚线之间空隙的长度
        borderLayer.lineDashPhase = 0.1;
        //实线边框
        
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        self.layer.addSublayer(borderLayer)
    }
}
