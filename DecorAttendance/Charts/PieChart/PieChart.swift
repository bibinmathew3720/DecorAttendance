////
////  PieChart.swift
////  DecorAttendance
////
////  Created by Sreejith n  krishna on 16/12/18.
////  Copyright © 2018 Sreeith n  krishna. All rights reserved.
////
////
//import UIKit
//import Charts
//
//class PieChart: NSObject {
//
//    class func initializeAndPlotGraph(chartView:PieChartView, controller: UIViewController, xCoordinateArr: NSArray, yCoordinateArr1: NSArray, yCoordinateArr2: NSArray, yCoordinate1Label: String, yCoordinate2Label: String) {
//
//        // Do any additional setup after loading the view.
//        controller.title = "Pie Chart"
//        self.setupGraphProperties(pieChartView: chartView)
//
//        chartView.delegate = controller as? ChartViewDelegate
//
//        let l = chartView.legend
//        l.horizontalAlignment = .right
//        l.verticalAlignment = .top
//        l.orientation = .vertical
//        l.xEntrySpace = 7
//        l.yEntrySpace = 0
//        l.yOffset = 0
//        //        chartView.legend = l
//
//        // entry label styling
//
//
//        chartView.entryLabelColor = .white
//        chartView.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
//        self.setChartData(12, range: 12, chartView: chartView, xAxisData: xCoordinateArr, yAxisData1: yCoordinateArr1, yAxisData2: yCoordinateArr2, yCoordinate1Label: yCoordinate1Label, yCoordinate2Label: yCoordinate2Label)
//        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
//        chartView.noDataText = ""
//
//    }
//
//    class func setupGraphProperties(pieChartView chartView: PieChartView) {
//
//        chartView.usePercentValuesEnabled = true
//        chartView.drawSlicesUnderHoleEnabled = false
//        chartView.holeRadiusPercent = 0.58
//        chartView.transparentCircleRadiusPercent = 0.61
//        chartView.chartDescription?.enabled = false
//        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
//
//        //chartView.drawCenterTextEnabled = true
//
//        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//        paragraphStyle.lineBreakMode = .byTruncatingTail
//        paragraphStyle.alignment = .center
//
//        //        let centerText = NSMutableAttributedString(string: "")
//        //        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
//        //                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
//        //        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//        //                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
//        //        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//        //                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
//        //        chartView.centerAttributedText = centerText;
//
//        chartView.drawHoleEnabled = true
//        chartView.rotationAngle = 0
//        chartView.rotationEnabled = true
//        chartView.highlightPerTapEnabled = true
//        chartView.noDataText = ""
//
//        let l = chartView.legend
//        l.horizontalAlignment = .right
//        l.verticalAlignment = .top
//        l.orientation = .vertical
//        l.drawInside = false
//        l.xEntrySpace = 7
//        l.yEntrySpace = 0
//        l.yOffset = 0
//        //        chartView.legend = l
//    }
//
//    class func setChartData(_ count: Int, range: UInt32, chartView: PieChartView, xAxisData: NSArray, yAxisData1: NSArray, yAxisData2: NSArray, yCoordinate1Label: String, yCoordinate2Label: String) {
//
//        let parties = xAxisData
//
//        let entries = (0..<xAxisData.count).map { (i) -> PieChartDataEntry in
//            // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
//            return PieChartDataEntry(value: Double(yAxisData1.object(at: i) as! String)!,
//                                     label: (parties[i % parties.count] as! String),
//                                     icon: nil)
//        }
//
//        let set = PieChartDataSet(values: entries, label: yCoordinate1Label)
//        set.drawIconsEnabled = false
//        set.sliceSpace = 4
//        //set.colors = [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)] +
//            //ChartColorTemplates.joyful()
//        set.colors = [ChartColorTemplates.colorFromString("#E92E2F"), ChartColorTemplates.colorFromString("#E91E63"), ChartColorTemplates.colorFromString("#FF7F00")]
//        set.valueTextColor = UIColor.black
//
//        let data = PieChartData(dataSet: set)
//
//        let pFormatter = NumberFormatter()
//        pFormatter.numberStyle = .percent
//        pFormatter.maximumFractionDigits = 1
//        pFormatter.multiplier = 1
//        pFormatter.percentSymbol = " %"
//        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
//
//        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
//        data.setValueTextColor(.black)
//
//        chartView.data = data
//        chartView.highlightValues(nil)
//
//    }
//
//
//}
