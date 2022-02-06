//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Владимир Белобродский on 06.02.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startLocationManager();
    }

    func startLocationManager()
    {
        //послать на устройство запрос на использования геопозиции при использовании приложения
        locationManager.requestWhenInUseAuthorization()
        
        //Если на устройстве включены службы геолокации
        if CLLocationManager.locationServicesEnabled() {
            
            //передать действие тому, кто будет обрабатывать при изменении координат, для этого нужно этот класс подписать на протокол  CLLocationManagerDelegate
            locationManager.delegate = self
            
            // точность 100 метров
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            locationManager.pausesLocationUpdatesAutomatically = false
            
            //запускаем слежку за локацией и при изменении будет запускаться метод из протокола CLLocationManagerDelegate
            locationManager.startUpdatingLocation()
            
        }
              
    }

}
// подпишем наш класс на протокол и в этом месте код будет отвечать за обработку изменений координат при перемещении
extension ViewController: CLLocationManagerDelegate{
    // тут нужно создать вункцию которая будет выполняться при изменении кординат для этого нужно начать писать "didUp"
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            print(lastLocation.coordinate.latitude,  lastLocation.coordinate.longitude)
            
        }
    }
    
}
