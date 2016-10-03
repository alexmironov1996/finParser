//
//  CurrencyView.swift
//  table
//
//  Created by macbook on 13.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
class CurrencyView:UIView{
    
    var moneyNameLabel:UILabel=UILabel()
    fileprivate var _moneyBuyText:UILabel=UILabel()
    fileprivate var _moneySellText:UILabel=UILabel()
    var moneyBuyValue:UILabel=UILabel()
    var moneySellValue:UILabel=UILabel()
    
    
    
    init(){
        super.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0))
        moneyNameLabel.translatesAutoresizingMaskIntoConstraints=false
        moneyNameLabel.layer.borderWidth=1
        self.addSubview(moneyNameLabel)
        
        _moneyBuyText.text="Покупка"
        _moneyBuyText.translatesAutoresizingMaskIntoConstraints=false
        _moneyBuyText.layer.borderWidth=1
        self.addSubview(_moneyBuyText)
        
        _moneySellText.translatesAutoresizingMaskIntoConstraints=false
        _moneySellText.text="Продажа"
        _moneySellText.layer.borderWidth=1
        self.addSubview(_moneySellText)
        
        moneySellValue.translatesAutoresizingMaskIntoConstraints=false
        moneySellValue.layer.borderWidth=1
        self.addSubview(moneySellValue)

        moneyBuyValue.translatesAutoresizingMaskIntoConstraints=false
        moneyBuyValue.layer.borderWidth=1
        self.addSubview(moneyBuyValue)
        
        NSLayoutConstraint.activate([
            
            moneyNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            moneyNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            moneyNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            moneyNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
            _moneyBuyText.topAnchor.constraint(equalTo: moneyNameLabel.bottomAnchor),
            _moneyBuyText.leftAnchor.constraint(equalTo: self.leftAnchor),
            _moneyBuyText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            _moneyBuyText.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25),
            
            _moneySellText.topAnchor.constraint(equalTo: moneyNameLabel.bottomAnchor),
            _moneySellText.rightAnchor.constraint(equalTo: self.rightAnchor),
            _moneySellText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            _moneySellText.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25),
            
            moneyBuyValue.topAnchor.constraint(equalTo: _moneyBuyText.bottomAnchor),
            moneyBuyValue.leftAnchor.constraint(equalTo: self.leftAnchor),
            moneyBuyValue.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            moneyBuyValue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            moneySellValue.topAnchor.constraint(equalTo: _moneyBuyText.bottomAnchor),
            moneySellValue.rightAnchor.constraint(equalTo: self.rightAnchor),
            moneySellValue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
