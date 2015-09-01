//
//  ViewController.swift
//  Indicator
//
//  Created by qzp on 15/8/14.
//  Copyright (c) 2015年 qzp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Indicator.show()
        
       // test()
        
//    var  yview = YView(frame: CGRectMake(0, 0, 200, 300))
//        yview.backgroundColor = UIColor.lightGrayColor()
//        self.view.addSubview(yview)
//        yview.trackColor = UIColor.blackColor()
//        yview.progressColor = UIColor.orangeColor()
//        yview.progress = 2
//        yview.progressWidth = 4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func test () {
        ///画圆
        /*enter：圆心的坐标
        radius：半径
        startAngle：起始的弧度
        endAngle：圆弧结束的弧度
        clockwise：YES为顺时针，No为逆时针*/
        
    //var view = UIView(frame: CGRectMake(100, 100, 40, 40))
        
        var path = UIBezierPath()
        path .addArcWithCenter(self.view.center, radius: 40, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        path .stroke()
        path.fill()
    
    }
}

