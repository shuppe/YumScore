//
//  TirDeDes.swift
//  YumScore
//
//  Created by Sylvain on 2015-04-05.
//  Copyright (c) 2015 Syl20UP. All rights reserved.
//

import Foundation

class TirDeDes: NilLiteralConvertible, Printable {
    
    var section = 0
    var ligneDeSection = 0
    var titre = ""
    var resultat: Int?
    var typeMain: TypeLigne = .Pointage
    
    required init(nilLiteral: ()) {
    }
    
    init(_ pSection: Int, _ ligne: Int, _ typeLigne: TypeLigne, _ titre: String) {
        section = pSection
        ligneDeSection = ligne
        typeMain = typeLigne
        self.titre = titre
    }

//    init(_ pSection: Int, _ ligne: Int, _ typeLigne: TypeLigne, _ titre: String, _ calcul: ()->Int) {
//        section = pSection
//        ligneDeSection = ligne
//        typeMain = typeLigne
//        self.titre = titre
//    }

    var description: String {
        var displayRes: String
        if let res = resultat {
            displayRes = "\(res)"
        }
        else {
            displayRes = "-"
        }
        return self.titre + "= " + displayRes
    }
    
    
}

