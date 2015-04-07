//
//  TotalTableViewCell.swift
//  YumScore
//
//  Created by Sylvain on 2015-04-06.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import UIKit

class TotalTableViewCell: UITableViewCell
{
        
    @IBOutlet weak var affichage: UILabel!
    
    var totalAAfficher: Int? {
        get {
            if let points = affichage.text {
                return points.toInt() ?? 0
            }
            else {
                return 0
            }
        }
        set {
            if let points = newValue {
                affichage.text = "\(points)"
            }
            else {
                affichage.text = ""
            }
        }
    }
}
