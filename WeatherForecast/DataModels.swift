//
//  DataModels.swift
//  WeatherForecast
//
//  Created by Владимир Белобродский on 06.02.2022.
//

import Foundation
//Codable already include Decodable and Encodable protocols
struct WeatherData:Codable{
//    {
//      "coord": {
//        "lon": 39.21,
//        "lat": 51.67
//      },
//      "weather": [
//        {
//          "id": 804,
//          "main": "Clouds",
//          "description": "пасмурно",
//          "icon": "04n"
//        }
//      ],
//      "base": "stations",
//      "main": {
//        "temp": -0.97,
//        "feels_like": -4.67,
//        "temp_min": -0.97,
//        "temp_max": -0.97,
//        "pressure": 1007,
//        "humidity": 100
//      },
//      "visibility": 9000,
//      "wind": {
//        "speed": 3,
//        "deg": 230
//      },
//      "clouds": {
//        "all": 96
//      },
//      "dt": 1644157382,
//      "sys": {
//        "type": 1,
//        "id": 9034,
//        "country": "RU",
//        "sunrise": 1644123265,
//        "sunset": 1644157203
//      },
//      "timezone": 10800,
//      "id": 472045,
//      "name": "Воронеж",
//      "cod": 200
//    }
    
    //Это структура приходится инициализировать иначе будет ошибка
    
   var weather : [Weather] = []
    var main: Main = Main()
    var name : String = ""
}

struct Weather: Codable
{
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
}

