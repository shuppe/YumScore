//
//  PointsTableViewCell.swift
//  YumScore
//
//  Created by Sylvain on 2015-04-05.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import UIKit
protocol PointsTableViewCellDatasource {
    func updatePoints(sender: PointsTableViewCell)
}

class PointsTableViewCell: UITableViewCell, UITextFieldDelegate
{

    var datasource: PointsTableViewCellDatasource?
    var cellIndexPath: NSIndexPath?
    
    @IBOutlet weak var tfPoints: UITextField!
    
    @IBAction func pointsUpdated() {
        self.endEditing(true)
        datasource?.updatePoints(self)
    }
    
    func ajouterPoints(points: String) {
        tfPoints.text = points
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.endEditing(true)
    }
    
    var cellPoints: Int? {
        get {
            if let points = tfPoints.text {
                return points.toInt() ?? 0
            }
            else {
                return 0
            }
        }
        set {
            if let points = newValue {
                tfPoints.text = "\(points)"
            }
            else {
                tfPoints.text = "-"
            }
        }
            
    }
    
}
