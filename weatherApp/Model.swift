//
//  Model.swift
//  weatherApp
//
//  Created by Владислав Лазарев on 22/08/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let location: Location?
    let current: Current?
    
    init(dictWeather: [String: Any]) {
        location = Location(dictLocation: (dictWeather["location"] as? [String: Any] ?? [:]))
        current = Current(dictCurrent: dictWeather["current"] as? [String: Any] ?? [:])
    }

    struct Location: Decodable {
        let name: String?
        
        init(dictLocation: [String: Any]) {
            name = dictLocation["name"] as? String ?? ""
        }
    }
    
    struct Current: Decodable {
        
        let temp_c: Int?
        let condition: Condition?
        
        init(dictCurrent: [String:Any]){
            temp_c = dictCurrent["temp_c"] as? Int ?? 0
            condition = Condition(dictCondition: (dictCurrent["condition"] as? [String: Any] ?? [:]))
        }
        
        struct Condition: Decodable {
            let text: String?
            let icon: String?
        
            init (dictCondition: [String: Any]) {
                text = dictCondition["text"] as? String ?? ""
                icon = dictCondition["icon"] as? String ?? ""
            }
        }
    }

    static func getWeather(from jsonData: Any) -> Weather {
        let jsonData = jsonData as? [String: Any]
        return Weather(dictWeather: jsonData!)
    }
}
