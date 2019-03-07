////
////  PieChartSliceView.swift
////  DecorAttendance
////
////  Created by Sreejith n  krishna on 21/12/18.
////  Copyright © 2018 Sreeith n  krishna. All rights reserved.
////
////
//
//import Foundation
//import UIKit
//import Darwin
//
//
////-----------------------------------
////-------------------------
//
//struct Slice
//{
//    var radius: CGFloat
//    var width:  CGFloat
//    init(
//        radius:     CGFloat = 1,
//        width:      CGFloat = 0.125
//        )
//    {
//        self.radius = radius
//        self.width = width
//    }
//}
//
//struct Style
//{
//    var isOuterCircleNeeded: Bool
//    init(isOuterCircleNeeded: Bool = false) {
//        self.isOuterCircleNeeded = isOuterCircleNeeded
//    }
//
//}
//
//
//
////------------------------------
////---------------------------
//@IBDesignable
//class PieChartSliceView: UIView, CAAnimationDelegate
//{
//    var animating: Bool = false
//    var dontAnimatePathChanges: Bool = false
//    var myAnimationDelegate: MyCAAnimationDelegateProtocol?
//    var oldSliceCount = 0
//    var colorIndex:Int = 0//MARK: ADDED EXTRA
//    var slices: [Slice] = []
//    var style: [Style] = []
//
//
//
//        {
//        didSet
//        {
//            self.updatePath()
//        }
//    }
//    let myShapeLayer: CAShapeLayer?
//    var myNewFillLayer: CAShapeLayer?
//
//    var path2 = UIBezierPath()
//
//    //Build a path for our pie graph based on the array slices.
//    func updatePath()
//    {
//        var totalWidth:CGFloat = 0.0
//        colorIndex = 0
//
//        //If the array is empty, return.
//        if slices.count == 0
//        {
//            return
//        }
//        if style.count == 0 {
//            return
//
//        }
//
//        if let myShapeLayer = myShapeLayer
//        {
//            myShapeLayer.removeAllAnimations()
//
//            //First count the total width value so we can make the size of each slice proportional
//            for aSlice in slices
//            {
//                totalWidth += aSlice.width
//            }
//
//            //MARK: ADDED text addition
//            var textLayers = [CATextLayer]()
//            let labelCount: Int!
//            labelCount = slices.count
//            for _ in 1...labelCount {
//
//                textLayers.append(CATextLayer())
//
//            }
//            //Setup for building our path.
//            let path = UIBezierPath()
//            let center = CGPoint(x: myShapeLayer.bounds.midX,
//                                 y: myShapeLayer.bounds.midY)
//            path.move(to: center)
//            var startAngle:CGFloat = 0.0
//            let maxRadius:CGFloat = min(self.bounds.size.width,
//                                        self.bounds.size.height)/2 - 5
//
//            //Loop through each slice
//            for aSlice in slices
//            {
//                let endAngle:CGFloat = startAngle + aSlice.width / totalWidth * CGFloat(Double.pi) * 2.0
//                let thisRadius = maxRadius * aSlice.radius
//                //        path.addArc(withCenter: center,
//                //          radius: thisRadius,
//                //          startAngle: startAngle,
//                //          endAngle: endAngle,
//                //          clockwise: true)
//                //        path.addLine(to: center)
//
//                //MARK: Add different colors to the each arc segments
//                let newPath = UIBezierPath()
//                newPath.addArc(withCenter: center,
//                               radius: thisRadius,
//                               startAngle: startAngle,
//                               endAngle: endAngle,
//                               clockwise: true)
//                newPath.addLine(to: center)
//
//                let fillNewColorLayer = CAShapeLayer()
//                //let labelLayer = CATextLayer()
//
//                fillNewColorLayer.path = newPath.cgPath
//                let centerFilLayer = CGPoint(x: fillNewColorLayer.bounds.midX,
//                                             y: fillNewColorLayer.bounds.midY)
//                fillNewColorLayer.fillColor = ObeidiColors.ColorThemes.obeidiPieGraphShades()[colorIndex]
//
//                //Add shadow to the arcs
//                fillNewColorLayer.shadowOffset = CGSize(width: 0, height: 2)
//                fillNewColorLayer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.37).cgColor
//                fillNewColorLayer.shadowOpacity = 1
//                fillNewColorLayer.shadowRadius = 12
//
//
//                self.layer.addSublayer(fillNewColorLayer)
//
//                addPercentageLabelToSegments(startAngle: startAngle, endAngle: endAngle, centerPoint: center, radius: thisRadius, fillNewColorLayer: fillNewColorLayer, textLayers: textLayers, aSlice: aSlice, colorIndex: colorIndex)
//                self.layer.insertSublayer(textLayers[colorIndex], above: fillNewColorLayer)
//                colorIndex += 1
//                //
//
//                myNewFillLayer = fillNewColorLayer
//                path.close()
//                //
//
//                startAngle = endAngle
//            }
//
//            drawCentreHoles(center: center, maxRadius: maxRadius)
//
//            //add outer graph
//            //        if slices.count == 2{
//            //
//            //            drawOuterPieChart(center: center, radius: maxRadius)
//            //        }
//
//            if style[0].isOuterCircleNeeded {
//
//                drawOuterPieChart(center: center, radius: maxRadius)
//            }
//
//
//
//            /*
//             If the number of slices is the same as last time, animate the change
//             If the number of slices changed then animation won't work
//             (path animation requires that the start and end path have the same number of control points
//             */
//            if oldSliceCount == slices.count && !animating
//            {
//                //Create a CABasicAnimation to animate the path
//                let pathAnimation = CABasicAnimation(keyPath: "path")
//
//                //Make the animation start from the old path
//                if let oldPath = myShapeLayer.path
//                {
//                    pathAnimation.fromValue = oldPath as AnyObject
//                }
//
//                //Animate the changes to the path
//                pathAnimation.toValue = path.cgPath as AnyObject
//                pathAnimation.duration = 0.3
//                //pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//                myShapeLayer.path = path.cgPath
//                pathAnimation.delegate = self
//                animating = true
//                myShapeLayer.add(pathAnimation, forKey: "path")
//            }
//            else
//            {
//                myShapeLayer.path = path.cgPath
//            }
//            oldSliceCount = slices.count
//        }
//
//
//    }
//
//    //------------------------------------
//
//    func setup()
//    {
//        if let requiredShapeLayer = myShapeLayer
//        {
//            requiredShapeLayer.frame = frame
//            requiredShapeLayer.strokeColor = UIColor(
//                red: 0,
//                green: 0,
//                blue: 0,
//                alpha: 0.5).cgColor
//
//            requiredShapeLayer.fillColor = ObeidiColors.ColorCode.obeidiLightOrange().cgColor
//
//            requiredShapeLayer.borderWidth = 0
//            requiredShapeLayer.borderColor = ObeidiColors.ColorCode.obeidiLightBlack().cgColor
//
//            self.layer.addSublayer(myShapeLayer!)
//        }
//
//    }
//
//    override init(frame: CGRect)
//    {
//        myShapeLayer = CAShapeLayer()
//        super.init(frame: frame)
//        self.setup()
//    }
//
//    required init?(coder aDecoder: NSCoder)
//    {
//
//        print("In \(#function)")
//        myShapeLayer = CAShapeLayer()
//        super.init(coder: aDecoder)
//        self.setup()
//    }
//
//    override func layoutSubviews()
//    {
//        super.layoutSubviews()
//        if let requiredShapeLayer = myShapeLayer
//        {
//            requiredShapeLayer.frame = self.layer.bounds
//        }
//        myShapeLayer?.removeAllAnimations()
//        self.colorIndex = 0//Reset the colorIndex
//        //self.updatePath()
//    }
//
//    func animationDidStop(_ theAnimation: CAAnimation, finished: Bool)
//    {
//        if myAnimationDelegate != nil
//        {
//            animating = false
//            myAnimationDelegate?.animationDidStop( theAnimation, finished: finished)
//        }
//    }
//    func drawCentreHoles(center: CGPoint, maxRadius: CGFloat){
//        //MARK: Add centre Holes
//        let inneraPath = UIBezierPath()
//        let outerPath = UIBezierPath()
//
//        inneraPath.addArc(withCenter: center, radius: maxRadius * 0.25, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
//        inneraPath.addLine(to: center)
//        let holeLayerOuter = CAShapeLayer()
//        holeLayerOuter.path = inneraPath.cgPath
//        holeLayerOuter.fillColor = ObeidiColors.ColorCode.obeidiCircleAsh().cgColor
//        self.layer.addSublayer(holeLayerOuter)
//
//        outerPath.addArc(withCenter: center, radius: maxRadius * 0.2, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
//        outerPath.addLine(to: center)
//        let holeLayerInner = CAShapeLayer()
//        holeLayerInner.path = outerPath.cgPath
//        holeLayerInner.fillColor = ObeidiColors.ColorCode.obeidiExactBlack().cgColor
//        self.layer.addSublayer(holeLayerInner)
//
//    }
//
//    func addPercentageLabelToSegments(startAngle: CGFloat, endAngle: CGFloat,centerPoint: CGPoint, radius: CGFloat, fillNewColorLayer: CAShapeLayer!, textLayers: [CATextLayer], aSlice: Slice, colorIndex: Int)  {
//
//        let normalEnd = endAngle < startAngle ? endAngle + CGFloat(2 * Double.pi) : endAngle
//        let centerAngle = startAngle + (normalEnd - startAngle) / 2
//
//        let arcCenterX = centerPoint.x + cos(centerAngle) * radius
//        let arcCenterY = centerPoint.y + sin(centerAngle) * radius
//
//        let yAdjuster: CGFloat!
//        if endAngle > CGFloat(Double.pi) {
//            yAdjuster = -15
//        }else{
//            yAdjuster = 15
//
//        }
//
//        let desiredPointX = (centerPoint.x + arcCenterX) / 2
//        let desiredPointY = (centerPoint.y + arcCenterY) / 2 + yAdjuster
//
//        textLayers[colorIndex].font = UIFont(name: ObeidiFont.Family.normalFont(), size: ObeidiFont.Size.smallB())
//        //labelLayer.frame = fillNewColorLayer.frame
//        textLayers[colorIndex].string = String(format: "%.0f", (aSlice.width * 100)) + "%"
//        textLayers[colorIndex].alignmentMode = CATextLayerAlignmentMode.left
//        textLayers[colorIndex].foregroundColor = ObeidiFont.Color.obeidiExactWhite().cgColor
//        textLayers[colorIndex].fontSize = ObeidiFont.Size.mediumB()
//
//        textLayers[colorIndex].frame = CGRect(x: desiredPointX,
//                                              y: desiredPointY, width: 50, height: 30)
//
//
//        //
//        fillNewColorLayer.addSublayer(textLayers[colorIndex])
//
//    }
//
//    func drawOuterPieChart(center: CGPoint, radius: CGFloat) {
//
//        let circlePathColoured = UIBezierPath()
//
//
//        circlePathColoured.addArc(withCenter: center, radius: radius * 0.95, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
//        circlePathColoured.addLine(to: center)
//        let circleLayerColoured = CAShapeLayer()
//        circleLayerColoured.path = circlePathColoured.cgPath
//        circleLayerColoured.strokeColor = ObeidiColors.ColorCode.obeidiDarkOrange().cgColor
//        circleLayerColoured.strokeStart = 0
//        circleLayerColoured.strokeEnd = 0.7
//        circleLayerColoured.lineWidth = 18
//        circleLayerColoured.fillColor = UIColor.clear.cgColor
//        circleLayerColoured.lineCap = .round
//
//        //unColoured
//        let circlePathUnColoured = UIBezierPath()
//
//        circlePathUnColoured.addArc(withCenter: center, radius: radius * 0.95, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
//        circlePathUnColoured.addLine(to: center)
//        let circleLayerUnColoured = CAShapeLayer()
//        circleLayerUnColoured.path = circlePathUnColoured.cgPath
//        circleLayerUnColoured.strokeColor = ObeidiColors.ColorCode.obeidiDarkOrange().cgColor
//        circleLayerUnColoured.strokeStart = 0.7
//        circleLayerUnColoured.strokeEnd = 0.86
//        circleLayerUnColoured.lineWidth = 18
//        circleLayerUnColoured.fillColor = UIColor.clear.cgColor
//        circleLayerUnColoured.opacity = 0.3
//
//
//        //add percentage label
//        let textLayer = CATextLayer()
//        textLayer.font = UIFont(name: ObeidiFont.Family.normalFont(), size: ObeidiFont.Size.smallB())
//        //labelLayer.frame = fillNewColorLayer.frame
//        textLayer.string = String(format: "%.0f", (0.7 * 100)) + "%"
//        textLayer.alignmentMode = CATextLayerAlignmentMode.left
//        textLayer.foregroundColor = ObeidiFont.Color.obeidiExactWhite().cgColor
//        textLayer.fontSize = ObeidiFont.Size.mediumB()
//
//        textLayer.frame = CGRect(x: Double(center.x) + cos(0.8 * 2 * Double.pi) * Double(radius) * 0.95 - 12, y: Double(center.y) + sin(0.8 * 2 * Double.pi) * Double(radius) * 0.95 - 6, width: 100, height: 50)
//
//        circleLayerColoured.addSublayer(textLayer)
//        self.layer.addSublayer(circleLayerColoured)
//        self.layer.addSublayer(circleLayerUnColoured)
//
//
//
//    }
//
//}
