//
//  ScoreCardModel.swift
//  YumScore
//
//  Created by Sylvain on 2015-03-28.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import Foundation

enum TypeLigne {case Pointage, Total }

class CarteDePointage: Printable {

    private enum MainsBas { case Brelan, Carre, Courte, Longue, Chance, MainPleine, Yum }
    
    struct Constants {
        static var desHaut = 9
        static var desBas = 10
    }
    
    init() {
        pointsRoules.append(TirDeDes(1,1, .Pointage, "Uns"))
        pointsRoules.append(TirDeDes(1,2, .Pointage, "Deux"))
        pointsRoules.append(TirDeDes(1,3, .Pointage, "Trois"))
        pointsRoules.append(TirDeDes(1,4, .Pointage, "Quatres"))
        pointsRoules.append(TirDeDes(1,5, .Pointage, "Cinqs"))
        pointsRoules.append(TirDeDes(1,6, .Pointage, "Six"))
        pointsRoules.append(TirDeDes(1,7, .Total, "Sous-total"))
        pointsRoules.append(TirDeDes(1,8, .Total, "Boni"))
        pointsRoules.append(TirDeDes(1,9, .Total, "Total"))

        pointsRoules.append(TirDeDes(2,1, .Pointage, "Brelan"))
        pointsRoules.append(TirDeDes(2,2, .Pointage, "Carré"))
        pointsRoules.append(TirDeDes(2,3, .Pointage, "Courte Séquence"))
        pointsRoules.append(TirDeDes(2,4, .Pointage, "Longue Séquence"))
        pointsRoules.append(TirDeDes(2,5, .Pointage, "Chance"))
        pointsRoules.append(TirDeDes(2,6, .Pointage, "Main Pleine"))
        pointsRoules.append(TirDeDes(2,7, .Pointage, "Yum"))
        pointsRoules.append(TirDeDes(2,8, .Total, "Total Haut"))
        pointsRoules.append(TirDeDes(2,9, .Total, "Total Bas"))
        pointsRoules.append(TirDeDes(2,10, .Total, "Total"))

    }
    
    var pointsRoules = Array<TirDeDes>()

    func getType(section: Int, _ mainJouee: Int) -> TypeLigne {
        return pointsRoules[indexDe(section, de: mainJouee)].typeMain
    }
    

    func getTitre(section: Int, _ mainJouee: Int) -> String {
        return pointsRoules[indexDe(section, de: mainJouee)].titre
    }
    
    func ajouterTitre(section: Int, _ mainJouee: Int, _ nouveauTitre: String) {
        pointsRoules[indexDe(section, de: mainJouee)].titre = nouveauTitre
    }
    
    func getScore(section: Int, _ mainJouee: Int) -> Int? {
        var score: Int?
        let main = pointsRoules[indexDe(section, de: mainJouee)]
        if main.typeMain == .Total {
            switch main.titre {
            case "Sous-total":
                score = SousTotalHaut()
            case "Boni":
                score = Boni()
            case "Total Haut":
                score = TotalHaut()
            case "Total Bas":
                score = TotalBas()
            case "Total":
                score = Total()
            default:
                score = nil
            }
        }
        else
        {
            score = main.resultat
        }
        return score
        
    }
    
    func ajouterScore(section: Int, mainJouee: Int, points:Int) {
        pointsRoules[indexDe(section, de: mainJouee)].resultat = points
    }
    
    private func sousTotal(section: Int) -> Int {
        var sousTotal = 0
        for (resultatTir) in pointsRoules {
            if resultatTir.section == section {
                sousTotal += resultatTir.resultat ?? 0
            }
        }
        return sousTotal

    }

    func TotalBas() -> Int {
            return sousTotal(2)
    }

    func TotalHaut() -> Int {
        return SousTotalHaut() + Boni()
    }
    
    func SousTotalHaut() -> Int {
        return sousTotal(1)
    }

    func Boni() -> Int {
        return SousTotalHaut() >= 63 ? 35 : 0
    }
    
    func Total() -> Int {
        return TotalHaut() + TotalBas()
    }
    
    func indexDe(section: Int, de: Int) -> Int {
        return (section-1)*Constants.desHaut + de-1
    }
    
    func tailleDeSection(section: Int) ->Int {
        return (section == 1) ? Constants.desHaut : Constants.desBas
    }
    
    var description: String {
        var desc = ""
        for tir in pointsRoules {
            desc = desc + "\(tir)\n"
            }
        return desc
    }
}
