//
//  Farm24ViewController.swift
//  PrimerosAuxsApp
//
//  Created by Carlos Lorca on 23/5/17.
//  Copyright © 2017 Carlos Lorca. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Farm24ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Farm24: MKMapView!
    
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Efecto a la imagen (Blur effect)
        background.image =  UIImage(named: "cascadaBackground")
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        background.addSubview(blurEffectView)
        
        performSearch()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacion = locations[0]
        
        let zoom:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        
        let miLocalizacion:CLLocationCoordinate2D = CLLocationCoordinate2DMake(localizacion.coordinate.latitude, localizacion.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(miLocalizacion, zoom)
        
        Farm24.setRegion(region, animated: true)
        
        self.Farm24.showsUserLocation = true
        
    }
    
    
    func performSearch() {
        
        matchingItems.removeAll()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "pharmacy 24 hours"
        request.region = Farm24.region
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            if error != nil {
                print("Error occured in search: \(error!.localizedDescription)")
            } else if response!.mapItems.count == 0 {
                print("No se han encontrado Farmacias 24H cerca de tu ubicación")
            } else {
                print("Se han encontrado Farmacias 24H cerca")
                
                for item in response!.mapItems {
                    print("Name \(item.name)")
                    print("Phone = \(item.phoneNumber)")
                    
                    self.matchingItems.append(item as MKMapItem)
                    print("Matching items = \(self.matchingItems.count)")
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.Farm24.addAnnotation(annotation)
                }
            }
        })
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
