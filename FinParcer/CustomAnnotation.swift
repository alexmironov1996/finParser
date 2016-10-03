//
//  CustomAnnotation.swift
//  FinParcer
//
//  Created by macbook on 28.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class CustomAnnotation: NSObject, MKAnnotation{
    fileprivate var _coordinate: CLLocationCoordinate2D!
    fileprivate var _title: String!
    fileprivate var _subtitle: String!
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        _coordinate = coordinate
        _title = title
        _subtitle = subtitle
    }
    var coordinate: CLLocationCoordinate2D {
        return _coordinate
    }
}
class CustomAnnotationView: MKAnnotationView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        image=UIImage(named:"mapFlag")
        canShowCallout=true
    }
}
