//
//  ViewController.swift
//  App Life Cycle
//
//  Created by Rodrigo Velazquez on 04/12/17.
//  Copyright © 2017 Rodrigo Velazquez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configurateMap()
        configureLocationManager()
        print("Carga el viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Aperecerá")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Aparecío")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: CoreLocation Methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            centerMap()
            
        }
        else {
            mapView.showsUserLocation = false
        }
    }
    
    
    

    // MARK: Private Methods
    
    private func configurateMap(){
        mapView.delegate = self
        mapView.mapType = .satellite
        mapView.showsUserLocation = false
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
    }
    
    private func configureLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .notDetermined || authorizationStatus == .denied{
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
            centerMap()
        }
    }
    
    private func centerMap () {
        
        let regionRadius: CLLocationDistance = 2000
        let userPosition = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let mapRegion = MKCoordinateRegionMakeWithDistance(userPosition.coordinate,regionRadius,regionRadius)
        mapView.setRegion(mapRegion, animated: true)
    }

}

