//
//  ViewController.swift
//  LocationTracker
//
//  Created by Mihir Kelkar on 8/17/14.
//  Copyright (c) 2014 Mihir Kelkar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var theMap: MKMapView!
    
    var manager: CLLocationManager!
    var mylocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Setting up our location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        //Setting up our Map
        theMap.delegate = self
        theMap.mapType = MKMapType.Satellite
        theMap.showsUserLocation = true
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        theLabel.text = "\(locations[0])"
        mylocations.append(locations[0] as CLLocation)
        let spanx = 1.0
        let spany = 1.0
        var newregion = MKCoordinateRegionMake(theMap.userLocation.coordinate, MKCoordinateSpanMake(spanx, spany))
        if (mylocations.count > 1){
            var sourceIndex = mylocations.count - 1
            var destinationIndex = mylocations.count - 2
            
            let c1 = mylocations[sourceIndex].coordinate
            let c2 = mylocations[destinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            theMap.addOverlay(polyline)
        }
    }

    //This function tells the map how to render the over lay for the Map View.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

