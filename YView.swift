

//
//  YView.swift
//  Indicator
//
//  Created by qzp on 15/8/14.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

class YView: UIView {
    var trackLayer: CAShapeLayer!
    var trackPath : UIBezierPath!
    var progressLayer: CAShapeLayer!
    var progressPath: UIBezierPath!
    
   
  
    var progress: CGFloat! {
        didSet {
            self.setProgress()
        }
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var progressColor: UIColor! {
        didSet{
            progressLayer.strokeColor = progressColor.CGColor
        }
    }
    var trackColor: UIColor! {
        didSet{
            trackLayer.strokeColor = trackColor.CGColor
        }
    }
    
    var progressWidth: CGFloat! = 5 {
        didSet{
            trackLayer.lineWidth = progressWidth
            progressLayer.lineWidth = progressWidth
          
            self.setProgress()
              self.setTrack()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        progressLayer = CAShapeLayer()
        self.layer.addSublayer(progressLayer)
        progressLayer.fillColor = nil;
        progressLayer.lineCap = kCALineCapRound
        progressLayer.frame = self.bounds
        
        trackLayer = CAShapeLayer()
        self.layer .addSublayer(trackLayer)
         trackLayer.fillColor = nil
        trackLayer.frame = self.bounds
        
      
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTrack() {
        trackPath = UIBezierPath()
        var radius = (self.bounds.size.width - progressWidth) / 2
        
        trackPath.addArcWithCenter(self.center, radius: radius, startAngle: 0, endAngle: CGFloat(0.5 * M_PI), clockwise: true)
        
        trackLayer.path = trackPath.CGPath
    }
    
    func setProgress() {
        progressPath = UIBezierPath()
        var radius = (self.bounds.size.width - progressWidth) / 2
        var startAngle: CGFloat = CGFloat(-M_PI_2)
        var endAngle: CGFloat = CGFloat(CGFloat(2 * CGFloat(M_PI)) * progress - CGFloat( M_PI_2))
        
        progressPath.addArcWithCenter(self.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressLayer.path = progressPath.CGPath
    }
    
    
 


}
