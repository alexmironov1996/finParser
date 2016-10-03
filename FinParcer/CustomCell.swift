//
//  CustomCell.swift
//  FinParcer
//
//  Created by macbook on 13.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
class CustomCell:UITableViewCell{
    var bankView:UILabel=UILabel()
    var euroView:CurrencyView=CurrencyView()
    var dollarView:CurrencyView=CurrencyView()
    var link:String?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bankView.translatesAutoresizingMaskIntoConstraints=false
        bankView.backgroundColor=UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        contentView.addSubview(bankView)
        
        dollarView.translatesAutoresizingMaskIntoConstraints=false
        
        dollarView.backgroundColor=UIColor(red: 210/255, green: 247/255, blue: 226/255, alpha: 1)
        contentView.addSubview(dollarView)
        
        euroView.translatesAutoresizingMaskIntoConstraints=false
        euroView.backgroundColor=UIColor(red: 163/255, green: 214/255, blue: 255/255, alpha: 1)
        contentView.addSubview(euroView)
        
        NSLayoutConstraint.activate([
            bankView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bankView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            bankView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bankView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            euroView.topAnchor.constraint(equalTo: bankView.bottomAnchor),
            euroView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            euroView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            euroView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            euroView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            dollarView.topAnchor.constraint(equalTo: bankView.bottomAnchor),
            dollarView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            dollarView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dollarView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            dollarView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)

            
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
