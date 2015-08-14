
//
//  Indicator.swift
//  Indicator
//
//  Created by qzp on 15/8/14.
//  Copyright (c) 2015年 qzp. All rights reserved.
//
//仿写
import UIKit
let QScreenWidth = UIScreen.mainScreen().bounds.width
let QScreenHeight = UIScreen.mainScreen().bounds.height
class Indicator: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    ///单例
    class var sharedInstance : Indicator {
        struct Static {
            static let sharedInstance = Indicator()
        }
        return Static.sharedInstance
    }
    
    ///设置window层级
    lazy var maskWindow: UIWindow? = {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.windowLevel = UIWindowLevelNormal
        return window
    }()

    
    lazy var indicatorLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.position = CGPoint(x: QScreenWidth/2, y: QScreenHeight/2)
        layer.path = UIBezierPath(arcCenter: CGPoint(x: layer.bounds.size.width/2, y: layer.bounds.size.height/2), radius: layer.bounds.size.width/2, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true).CGPath
        layer.lineWidth = 3
        layer.strokeColor = UIColor.orangeColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        layer.strokeEnd = 0
        layer.strokeStart = 0
        return layer
        }()
    
    lazy var strokeEndAnimation: CABasicAnimation = {
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        end.duration = 1
        end.fromValue = 0
        end.toValue = 0.95
        end.removedOnCompletion = false
        end.fillMode = kCAFillModeForwards
        return end
        }()
    
    lazy var strokeStartAnimation: CABasicAnimation = {
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        start.duration = 1
        start.fromValue = 0
        start.toValue = 0.95
        start.beginTime = 1
        start.removedOnCompletion = false
        start.fillMode = kCAFillModeForwards
        return start
        }()
    
    ///动画组
    lazy var animaionGroup: CAAnimationGroup = {
        let group = CAAnimationGroup()
        group.animations = [self.strokeEndAnimation, self.strokeStartAnimation]
        group.repeatCount = HUGE
        group.duration = 2
        return group
        }()
    
    lazy var rotateZAnimation: CABasicAnimation = {
        let  rotateZ = CABasicAnimation(keyPath: "transform.rotation.y")
        rotateZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        rotateZ.duration = 2
        rotateZ.fromValue = 0
        rotateZ.toValue = 2 * M_PI
        rotateZ.repeatCount = HUGE
        return rotateZ
        
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0
        self.frame = self.maskWindow!.bounds
        self.layer.addSublayer(self.indicatorLayer)
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///添加动画
    func beginIndicatiorAnimation() {
        indicatorLayer.addAnimation(animaionGroup, forKey: "group")
        indicatorLayer.addAnimation(rotateZAnimation, forKey: "rotationZ")
    }
    
    ///开始动画
    func beginAnimation() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.alpha = 1
        }) { (b) -> Void in
            self.beginIndicatiorAnimation()
        }
    }
    ///结束动画
    func endAnimationWithCompletion(complection: ()->()) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.alpha = 0
            self.indicatorLayer.removeAllAnimations()
            }) { (_ ) -> Void in
                complection()
        }
    }
    
    ///开始展现
    class func  show() {
        sharedInstance.maskWindow!.makeKeyAndVisible()
        sharedInstance.maskWindow!.addSubview(sharedInstance)
        sharedInstance.beginAnimation()
    }
    
    ///隐藏
    
    class func dismiss() {
        sharedInstance.endAnimationWithCompletion { () -> () in
            self.sharedInstance.maskWindow!.resignKeyWindow()
            self.sharedInstance.removeFromSuperview()
            
            let originalWindow = UIApplication.sharedApplication().delegate!.window
            originalWindow!?.makeKeyAndVisible()
        }
    }
}
