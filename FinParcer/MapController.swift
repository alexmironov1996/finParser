//
//  MapController.swift
//  FinParcer
//
//  Created by macbook on 27.07.16.
//  Copyright © 2016 macbook. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension MapVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            _mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
class MapVC:UIViewController,MKMapViewDelegate{
    fileprivate var _mapView:MKMapView=MKMapView()
    fileprivate let _regionRadius: CLLocationDistance = 1000
    fileprivate let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate=self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        centerMapOnLocation(locationManager.location!)
        
        _mapView.mapType = MKMapType.standard
        _mapView.delegate=self
        _mapView.frame=view.frame
        _mapView.isZoomEnabled = true
        _mapView.isScrollEnabled = true
        _mapView.showsUserLocation=true
        view.addSubview(_mapView)
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Владимир сбербанк"
        request.region = _mapView.region
        
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            var placemarks:[MKAnnotation] = []
            for item in response!.mapItems {
                placemarks.append(CustomAnnotation(coordinate: item.placemark.coordinate, title: item.placemark.title!, subtitle: ""))
            }
            self._mapView.removeAnnotations(self._mapView.annotations)
            self._mapView.showAnnotations(placemarks, animated: true)

        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: CustomAnnotation.self){
            let customView=MKAnnotationView(annotation: annotation, reuseIdentifier: "shit")
            customView.image = UIImage(named:"mapFlag")
            //customView.canShowCallout = true
            return customView
        }
        return nil
        
    }
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  _regionRadius * 2.0, _regionRadius * 2.0)
        _mapView.setRegion(coordinateRegion, animated: true)
    }
}

