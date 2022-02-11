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
// ModelData
    var weatherData = WeatherData()
    
    var fl=true
    var cnt = 0

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
    
    func updateView()
    {
        print(self.weatherData)
    }
    
    func updateWeatherInfo(latitude: Double, longtitude: Double){
        
        //url сессия по шаблону синглетон
        let session = URLSession.shared
       
        //.description convert Double to Text
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&units=metric&lang=ru&appid=ddc7533529baedb5cda5b2309a455707")!
        
        //print("http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longtitude.description)&units=metric&lang=ru&appid=ddc7533529baedb5cda5b2309a455707")
        
        let task = session.dataTask(with: url) { data, response, error in
                //ЭТОТ ПЕРЕХВАТЫВАЮЩИЙ КОД ВЫПОЛНЯЕТСЯ В ДРУГОМ ПОТОКЕ, НЕЖЕЛИ ПОТОК ОСНОВНОГО ПРИЛОЖЕНИЯ
            
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }
            
            
            guard let data = data else {
                print("dataUnwrapping Error in guard data=data")
                return
            }
           do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                
                //ЭТОТ КОМПЛИШЕН ХЕНДЛЯР ВЫПОЛНЯЕТСЯ В ДРУГОМ ПОТОКЕ - НЕ В ТОМ В КОТОРОМ ВЫПОЛНЯЕТСЯ ПРИЛОЖЕНИЕ
               
               //поэтому парралелльно асинхроно запускаем основному потоку
               //DispatchQueue.main.async
               //{  //ЭТУ СТРОЧКУ НУЖНО РАЗБИРАТЬ В ОТДЕЛЬНОМ КУРСЕ ПРО МНОГОПОТОЧНОСТЬ,
                   ///ОНА НУЖНО ДЛЯ ТОГО ЧТОБЫ
                   ///ОБНОВИТЬ ИНТЕРФЕЙС ОСНОВНОГО ПРИЛОЖЕНИЯ
                   self.updateView()
              // }
               
            }
            catch {
                print("JsonDecoder on do try error \(error)")
            }
        } //task // ЭТОТ КОМПЛИШЕН ХЕНДЛЯР ВЫПОЛНЯЕТСЯ В ДРУГОМ ПОТОКЕ - НЕ В ТОМ В КОТОРОМ ВЫПОЛНЯЕТСЯ ПРИЛОЖЕНИЕ
        
        
        task.resume() //запустим
        
    } //updateWeather
} //viewController


// подпишем наш класс на протокол и в этом месте код будет отвечать за обработку изменений координат при перемещении
extension ViewController: CLLocationManagerDelegate{
    // тут нужно создать вункцию которая будет выполняться при изменении кординат для этого нужно начать писать "didUp"
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        cnt+=1;
        if let lastLocation = locations.last {
            //print(lastLocation.coordinate.latitude,  lastLocation.coordinate.longitude)
            if fl {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longtitude: lastLocation.coordinate.longitude)
            // fl = false
                print("Cnt=\(cnt)")
            }
        }
    }
}
