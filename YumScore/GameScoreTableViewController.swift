//
//  GameScoreTableViewController.swift
//  YumScore
//
//  Created by Sylvain on 2015-04-05.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import UIKit

class GameScoreTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PointsTableViewCellDatasource
{
    
    private var carte = CarteDePointage()


    @IBOutlet weak var scoreTableView: UITableView!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return carte.tailleDeSection(section+1)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch carte.getType(indexPath.section+1, indexPath.row+1)
        {
        case .Pointage:
            var cellule = tableView.dequeueReusableCellWithIdentifier("points") as PointsTableViewCell
            cellule.cellIndexPath = indexPath
            cellule.datasource = self
            
            cellule.textLabel?.text = carte.getTitre(indexPath.section+1, indexPath.row+1)
            cellule.cellPoints = carte.getScore(indexPath.section+1, indexPath.row+1)
            
            return cellule
        case .Total:
            var cellule = tableView.dequeueReusableCellWithIdentifier("totaux") as TotalTableViewCell
            
            cellule.textLabel?.text = carte.getTitre(indexPath.section+1, indexPath.row+1)
            cellule.totalAAfficher = carte.getScore(indexPath.section+1, indexPath.row+1)
            
            return cellule
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Haut"
        }
        else {
            return "Bas"
        }
    }
    
    func updatePoints(cellule: PointsTableViewCell) {
        if let indexPath = cellule.cellIndexPath {
                carte.ajouterScore(indexPath.section+1, mainJouee: indexPath.row+1, points: cellule.cellPoints ?? 0)
        }
        scoreTableView.reloadData()
        println("\(carte)")
    }
    
}
