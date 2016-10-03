//
//  BankInfoController.swift
//  FinParcer
//
//  Created by macbook on 18.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
class BankInfoController:UIViewController{
    fileprivate var _infoURL:String=HTMLParser.homeLink
    fileprivate var _bankIcon:UIImageView=UIImageView()
    fileprivate var _backView:UIView=UIView()
    fileprivate var _bankName:UILabel=UILabel()
    fileprivate var _fullBankName:UILabel=UILabel()
    fileprivate var _addressLabel:UILabel=UILabel()
    fileprivate var _phoneLabel:UILabel=UILabel()
    fileprivate var _mapButton:UIButton=UIButton()
    
    fileprivate var _bankDescriptionTask:URLSessionTask?
    fileprivate var _imageTask:URLSessionTask?
    fileprivate var _activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
    init(url:String){
        super.init(nibName: nil, bundle: nil)
        _infoURL=_infoURL+url
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _activityIndicator.center=view.center
        _activityIndicator.startAnimating()
        view.addSubview(_activityIndicator)
        
        self.view.backgroundColor=UIColor.white
        
        _backView.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(_backView)
        
        _bankIcon.translatesAutoresizingMaskIntoConstraints=false
        _bankIcon.contentMode = .center
        view.addSubview(_bankIcon)
        
        _bankName.translatesAutoresizingMaskIntoConstraints=false
        _bankName.lineBreakMode = .byWordWrapping
        _bankName.numberOfLines=5
        _backView.addSubview(_bankName)
        
        
        _fullBankName.translatesAutoresizingMaskIntoConstraints=false
        _fullBankName.lineBreakMode = .byWordWrapping
        _fullBankName.numberOfLines=6
        _backView.addSubview(_fullBankName)
        
        _addressLabel.translatesAutoresizingMaskIntoConstraints=false
        _addressLabel.lineBreakMode = .byWordWrapping
        _addressLabel.numberOfLines=2
        _backView.addSubview(_addressLabel)
        
        _phoneLabel.translatesAutoresizingMaskIntoConstraints=false
        _phoneLabel.lineBreakMode = .byWordWrapping
        _phoneLabel.numberOfLines=2
        _backView.addSubview(_phoneLabel)
        
        _mapButton.translatesAutoresizingMaskIntoConstraints=false
        _mapButton.setTitle("Показать на карте", for: UIControlState())
        _mapButton.backgroundColor=UIColor.orange
        _mapButton.addTarget(self, action: #selector(BankInfoController.showMap(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(_mapButton)
        
        NSLayoutConstraint.activate([
            _bankIcon.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            _bankIcon.leftAnchor.constraint(equalTo: view.leftAnchor),
            _bankIcon.widthAnchor.constraint(equalToConstant: 100),
            _bankIcon.heightAnchor.constraint(equalToConstant: 50),
            
            _backView.topAnchor.constraint(greaterThanOrEqualTo: topLayoutGuide.bottomAnchor),
            _backView.rightAnchor.constraint(equalTo: view.rightAnchor),
            _backView.leftAnchor.constraint(equalTo: _bankIcon.rightAnchor),
            _backView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

            
            _bankName.topAnchor.constraint(equalTo: _backView.topAnchor),
            _bankName.rightAnchor.constraint(equalTo: _backView.rightAnchor),
            _bankName.leftAnchor.constraint(equalTo: _bankIcon.rightAnchor),
            _bankName.heightAnchor.constraint(equalTo: _backView.heightAnchor, multiplier: 0.3),
            
            
            _fullBankName.topAnchor.constraint(equalTo: _bankName.bottomAnchor, constant: -5),
            _fullBankName.leftAnchor.constraint(equalTo: _bankIcon.rightAnchor),
            _fullBankName.rightAnchor.constraint(equalTo: _backView.rightAnchor),
            _fullBankName.heightAnchor.constraint(greaterThanOrEqualTo: _backView.heightAnchor, multiplier: 0.2),
            
            _addressLabel.topAnchor.constraint(equalTo: _fullBankName.bottomAnchor, constant: -5),
            _addressLabel.leftAnchor.constraint(equalTo: _bankIcon.rightAnchor),
            _addressLabel.rightAnchor.constraint(equalTo: _backView.rightAnchor),
            _addressLabel.heightAnchor.constraint(equalTo: _backView.heightAnchor, multiplier: 0.2),
            
            _phoneLabel.topAnchor.constraint(equalTo: _addressLabel.bottomAnchor, constant: -5),
            _phoneLabel.leftAnchor.constraint(equalTo: _bankIcon.rightAnchor),
            _phoneLabel.rightAnchor.constraint(equalTo: _backView.rightAnchor),
            _phoneLabel.heightAnchor.constraint(greaterThanOrEqualTo: _backView.heightAnchor, multiplier: 0.2),
            
            _mapButton.topAnchor.constraint(lessThanOrEqualTo: _backView.bottomAnchor, constant:40),
            _mapButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            _mapButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            _mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            //view.topAnchor.constraintEqualToAnchor(navigationController?.navigationBar.bottomAnchor)
            
            ])
        
        _bankDescriptionTask=HTMLParser.getBankDescription(URL(string: _infoURL)!, setUploadedValues: setUploadedValues)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        if(navigationController?.viewControllers.index(of: self)==NSNotFound){
            _bankDescriptionTask?.cancel()
            _imageTask?.cancel()
        }
        super.viewWillDisappear(true)
    }

    func setUploadedValues(_ iconLink:String, name:String, fullName:String, address:String, phone:String){
        let link=HTMLParser.homeLink+iconLink
        print(_infoURL)
        _imageTask=HTMLParser.downloadImage(URL(string: link)!, setImage: setIcon)
        _bankName.text=name
        _fullBankName.text=fullName
        _addressLabel.text=address
        _phoneLabel.text=phone
    }
    func setIcon(_ icon:UIImage){
        _activityIndicator.stopAnimating()
        _bankIcon.image=icon
    }
    func showMap(_ sender:UIButton){
        self.navigationController?.pushViewController(MapVC(), animated: true)
    }
}
