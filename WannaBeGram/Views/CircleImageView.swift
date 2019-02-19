//
//  CircleImageView.swift
//  WannaBeGram
//
//  Created by Abid Amirali on 2/18/19.
//  Copyright © 2019 Abid Amirali. All rights reserved.
//

import UIKit

class CircleImageView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let pointX = self.frame.origin.x + self.bounds.width / 18
        let pointY = self.frame.origin.y - self.bounds.height / 2
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: pointX, y: pointY), radius: self.bounds.width / 3, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
//        shapeLayer.fillColor = UIColor.clear.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.red.cgColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        shapeLayer.contents = UIImage(named: "create_user_profile_photo_placeholder")?.cgImage
        
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
    
    
    

}
