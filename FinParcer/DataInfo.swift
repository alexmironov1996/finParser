//
//  DataInfo.swift
//  FinParcer
//
//  Created by macbook on 13.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
class CellData{
    var bankName:String?
    var dollarBuy:Double!
    var dollarSell:Double!
    var euroBuy:Double!
    var euroSell:Double!
    var infoLink:String?
    
    var dollarColorBuy:UIColor?
    var dollarColorSell:UIColor?
    var euroColorBuy:UIColor?
    var euroColorSell:UIColor?
    
    init(bankName:String, dollarBuy:String, dollarSell:String, euroBuy:String, euroSell:String,
        infoLink:String, db:UIColor, ds:UIColor, eb:UIColor, es:UIColor){
        self.bankName=bankName
        self.dollarBuy=Double(dollarBuy)
        self.dollarSell=Double(dollarSell)
        self.euroBuy=Double(euroBuy)
        self.euroSell=Double(euroSell)
        self.infoLink=infoLink
        self.dollarColorBuy=db
        self.dollarColorSell=ds
        self.euroColorBuy=eb
        self.euroColorSell=es
    }

    
}