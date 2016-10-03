//
//  HTMLParser.swift
//  FinParcer
//
//  Created by macbook on 18.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
import HTMLReader

class HTMLParser {
    static let homeLink="http://www.fin33.ru"
    static func getBankList(_ returnControl:@escaping ([CellData])->Void)->Void{
        let url = URL(string:homeLink)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            var contentType: String? = nil
            if let response = response as? HTTPURLResponse {
                contentType = response.allHeaderFields["Content-Type"] as? String
            }
            if let data = data {
                DispatchQueue.main.async(execute: {
                    //finding needed html block
                    let doc = HTMLDocument(data: data, contentTypeHeader:contentType)
                    let rows=doc.nodes(matchingSelector: ".otscourses tr")
                    var iter=2
                    var data:[CellData]=[]
                    while iter<rows.count{
                        let cell=rows[iter].nodes(matchingSelector: "td")
                        
                        let bankHTML=cell[0].nodes(matchingSelector: "a")
                        
                        var colors:[UIColor]=[]
                        for i in 1...4{
                            let top=cell[i].nodes(matchingSelector: ".best")
                            if top.count>0 {
                                colors.append(UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1))
                            }
                            else{
                                colors.append(UIColor(red: 117/255, green: 117/255, blue: 163/255, alpha: 1))
                            }
                        }
                        let cellObj:CellData = CellData(bankName: bankHTML[0].textContent,
                            dollarBuy: cell[1].textContent,dollarSell: cell[2].textContent,
                            euroBuy: cell[3].textContent,euroSell: cell[4].textContent,
                            infoLink:bankHTML[0].attributes["href"]!,
                            db:colors[0],ds:colors[1],eb:colors[2],es:colors[3]
                        )
                        data.append(cellObj)
                        iter+=1
                    }
                    returnControl(data)
                })
                
            }
                        
        }) 
        task.resume()
    }
    static func getBankDescription(_ url:URL,setUploadedValues:@escaping (String, String, String, String,String)->Void)->URLSessionDataTask{
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            var contentType: String? = nil
            print("callback")
            if let response = response as? HTTPURLResponse {
                contentType = response.allHeaderFields["Content-Type"] as? String
            }
            if let data = data {
                DispatchQueue.main.async(execute: {
                    //finding needed html block
                    let doc = HTMLDocument(data: data, contentTypeHeader:contentType)
                    let rows=doc.nodes(matchingSelector: ".otscolleft tr")
                    
                    let imageContainer=rows[0].nodes(matchingSelector: "img")
                    
                    let bankTitleContainer=rows[0].nodes(matchingSelector: "h2")
                    
                    let bankContactInfoContainer=rows[0].nodes(matchingSelector: "p")
                    
                    setUploadedValues(imageContainer[0].attributes["src"]!,bankTitleContainer[0].textContent,bankContactInfoContainer[0].textContent,bankContactInfoContainer[1].textContent,bankContactInfoContainer[2].textContent)

                })
                
            }
            
        }) 
        task.resume()
        return task
    }
    static func downloadImage(_ url:URL,setImage:@escaping (UIImage)->Void)->URLSessionDataTask{
        print(url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let data = data {
                DispatchQueue.main.async(execute: {
                    setImage(UIImage(data: data)!)
                })
            }
            
        }) 
        task.resume()
        return task
    }



}
