//
//  OvalTabbBarView.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class OvalTabbBarView: UIView {
    
    func addBezPath() {
        let bezPathStage2: UIBezierPath = UIBezierPath()
        bezPathStage2.move(to: CGPoint(x: 20, y: 12))
        bezPathStage2.addLine(to: CGPoint(x: 30, y: 3))
        bezPathStage2.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezPathStage2.cgPath
        shapeLayer.fillColor = UIColor.gray.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        layer.addSublayer(shapeLayer)
    }
    
}
