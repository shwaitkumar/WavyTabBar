//
//  CustomTabBar.swift
//  WavyTabBar
//
//  Created by Shwait Kumar on 03/02/23.
//

import UIKit

class CustomTabBar: UITabBar {
    
    private var shapeLayer: CAShapeLayer?
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.secondarySystemBackground.cgColor
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    func createPath() -> CGPath {
        let height: CGFloat = 40.0 // Height of the wave-like curve
        let extraHeight: CGFloat = -20.0 // Additional height for top left and top right corners
        let path = UIBezierPath()
        let width = self.frame.width
        // Creating a wave-like top edge for tab bar starting from left side
        path.move(to: CGPoint(x: 0, y: extraHeight)) // Start at top left corner with extra height
        path.addQuadCurve(to: CGPoint(x: width/2, y: extraHeight), controlPoint: CGPoint(x: width/4, y: extraHeight - height))
        path.addQuadCurve(to: CGPoint(x: width, y: extraHeight), controlPoint: CGPoint(x: width*3/4, y: extraHeight + height))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }

    func updateShape(with selectedIndex: Int) {
        let shapeLayer = CAShapeLayer()
        let height: CGFloat = 40.0
        let extraHeight: CGFloat = -20.0
        let width = self.frame.width

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: extraHeight))
        if selectedIndex == 0 {
            path.addQuadCurve(to: CGPoint(x: width / 2, y: extraHeight), controlPoint: CGPoint(x: width / 4, y: extraHeight - height))
            path.addQuadCurve(to: CGPoint(x: width, y: extraHeight), controlPoint: CGPoint(x: width / 2 + width / 4, y: extraHeight + height))
        }
        else if selectedIndex == 1 {
            path.addQuadCurve(to: CGPoint(x: width / 2 + width / 4, y: extraHeight), controlPoint: CGPoint(x: width / 4 + width / 4, y: extraHeight - height))
            path.addQuadCurve(to: CGPoint(x: width, y: extraHeight), controlPoint: CGPoint(x: width * 3 / 4 + width / 4, y: extraHeight + height))
        }
        else if selectedIndex == 2 {
            let xShift = width / 4
            path.addQuadCurve(to: CGPoint(x: width / 2 + xShift, y: extraHeight), controlPoint: CGPoint(x: width / 8 + xShift, y: extraHeight + height))
            path.addQuadCurve(to: CGPoint(x: width, y: extraHeight), controlPoint: CGPoint(x: width * 7 / 8 + xShift, y: extraHeight - height))
        }
        else {
            path.addQuadCurve(to: CGPoint(x: width / 2, y: extraHeight), controlPoint: CGPoint(x: width / 4, y: extraHeight + height))
            path.addQuadCurve(to: CGPoint(x: width, y: extraHeight), controlPoint: CGPoint(x: width / 2 + width / 4, y: extraHeight - height))
        }
        path.addLine(to: CGPoint(x: width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.secondarySystemBackground.cgColor

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }
    
}
