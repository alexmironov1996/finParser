//
//  ViewController.swift
//  FinParcer
//
//  Created by macbook on 11.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import UIKit
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    fileprivate var _dataArray:[CellData]=[]
    fileprivate var _table:UITableView=UITableView()
    fileprivate var _segmentedControl:UISegmentedControl=UISegmentedControl(items: ["евро","доллар"])
    
    fileprivate var _activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:
        UIActivityIndicatorViewStyle.gray)
    fileprivate var _timer=Timer()
    fileprivate var _refreshControl:UIRefreshControl!
    fileprivate var _sortType:Int!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        _activityIndicator.center=view.center
        _activityIndicator.startAnimating()
        _table.addSubview(_activityIndicator)
        
        _table.delegate      =   self
        _table.dataSource    =   self
        _table.register(CustomCell.self, forCellReuseIdentifier: "cell")
        _table.frame=view.frame
        _table.translatesAutoresizingMaskIntoConstraints=false
        _table.estimatedRowHeight = 80.0
        _table.rowHeight = UITableViewAutomaticDimension
        
        view.addSubview(_table)
        
        _segmentedControl.selectedSegmentIndex=0
        _sortType=0
        _segmentedControl.addTarget(self, action: #selector(ViewController.showBestDeals(_:)), for: .valueChanged)
        _segmentedControl.translatesAutoresizingMaskIntoConstraints=false
        navigationController!.navigationBar.addSubview(_segmentedControl)
        //download data on init
        refresh()
        
        //update data on tableView scroll
        _refreshControl=UIRefreshControl()
        _refreshControl.addTarget(self, action:#selector(ViewController.refresh) , for: UIControlEvents.valueChanged)
        _table.addSubview(_refreshControl)

        NSLayoutConstraint.activate([
            _table.topAnchor.constraint(equalTo: view.topAnchor),
            _table.leftAnchor.constraint(equalTo: view.leftAnchor),
            _table.rightAnchor.constraint(equalTo: view.rightAnchor),
            _table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            _segmentedControl.topAnchor.constraint(equalTo: navigationController!.navigationBar.topAnchor),
            _segmentedControl.rightAnchor.constraint(equalTo: navigationController!.navigationBar.rightAnchor),
            _segmentedControl.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor),
            
            _segmentedControl.widthAnchor.constraint(equalTo: navigationController!.navigationBar.widthAnchor, multiplier: 0.8)
            ])
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        _timer=Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.refresh), userInfo: nil, repeats: true)
        _segmentedControl.isHidden=false
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=CustomCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.bankView.text=_dataArray[(indexPath as NSIndexPath).row].bankName
        cell.dollarView.moneyNameLabel.text="Доллар"
        cell.dollarView.moneyBuyValue.text=String(_dataArray[(indexPath as NSIndexPath).row].dollarBuy)
        cell.dollarView.moneyBuyValue.backgroundColor=_dataArray[(indexPath as NSIndexPath).row].dollarColorBuy
        
        cell.dollarView.moneySellValue.text=String(_dataArray[(indexPath as NSIndexPath).row].dollarSell)
        cell.dollarView.moneySellValue.backgroundColor=_dataArray[(indexPath as NSIndexPath).row].dollarColorSell

        
        cell.euroView.moneyNameLabel.text="Евро"
        cell.euroView.moneyBuyValue.text=String(_dataArray[(indexPath as NSIndexPath).row].euroBuy)
        cell.euroView.moneyBuyValue.backgroundColor=_dataArray[(indexPath as NSIndexPath).row].euroColorBuy
        
        cell.euroView.moneySellValue.text=String(_dataArray[(indexPath as NSIndexPath).row].euroSell)
        cell.euroView.moneySellValue.backgroundColor=_dataArray[(indexPath as NSIndexPath).row].euroColorSell

        
        cell.link=_dataArray[(indexPath as NSIndexPath).row].infoLink
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _timer.invalidate()
        _segmentedControl.isHidden=true
        self.navigationController?.pushViewController(BankInfoController(url: _dataArray[(indexPath as NSIndexPath).row].infoLink!), animated: true)
    }
    func showBestDeals(_ sender: UISegmentedControl){
        _sortType=sender.selectedSegmentIndex
        sort()
    }
    func sort(){
        switch _sortType{
        case 0:
            _dataArray.sort(by: {$0.euroBuy>$1.euroBuy})
            _table.reloadData()
        case 1:
            _dataArray.sort(by: {$0.dollarBuy>$1.dollarBuy})
            _table.reloadData()
        default:
            break
        }
    }
    func refresh(){
        print("refresh")
        HTMLParser.getBankList(setData)
    }
    func setData(_ data:[CellData])->Void{
        _activityIndicator.stopAnimating()
        _dataArray=data
        sort()
        _table.reloadData()
        _refreshControl.endRefreshing()
    }
    
 
}



    
