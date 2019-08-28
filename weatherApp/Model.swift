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

    struct Location: Decodable {
        let name: String?
        let region: String?
        let country: String?
        let lat: Double?
        let lon: Double?
        let tz_id: String?
        let localtime_epoch: Int?
        let localtime: String?
        
    }
    
    struct Current: Decodable {
        let last_updated_epoch: Int?
        let last_updated: String?
        let temp_c: Int?
        let temp_f: Double?
        let is_day: Int?
        let condition: Condition?
        let wind_mph: Double?
        let wind_kph: Double?
        let wind_degree: Int?
        let wind_dir: String?
        let pressure_mb: Double?
        let pressure_in: Double?
        let precip_mm: Double?
        let precip_in: Double?
        let humidity: Int?
        let cloud: Int?
        let feelslike_c: Double?
        let feelslike_f: Double?
        let vis_km: Double?
        let vis_miles: Double?
        let uv: Double?
        let gust_mph: Double?
        let gust_kph: Double?
        
        init(dictCurrent: [String:Any]){
            last_updated_epoch = dictCurrent["last_updated_epoch"] as? Int ?? 0
            last_updated = dictCurrent["last_updated"] as? String ?? ""
            temp_c = dictCurrent["temp_c"] as? Int ?? 0
            temp_f = dictCurrent["temp_f"] as? Double ?? 0
            is_day = dictCurrent["is_day"] as? Int ?? 0
            condition = Condition(dictCondition: (dictCurrent["condition"] as? [String: Any] ?? [:])
            wind_mph = dictCurrent["wind_mph"] as? String ?? ""
            wind_kph = dictCurrent["wind_kph"] as? String ?? ""
            wind_degree = dictCurrent["wind_degree"] as? String ?? ""
            wind_dir = dictCurrent["wind_dir"] as? String ?? ""
            pressure_mb = dictCurrent["pressure_mb"] as? String ?? ""
            pressure_in = dictCurrent["pressure_in"] as? String ?? ""
            precip_mm = dictCurrent["precip_mm"] as? String ?? ""
            precip_in = dictCurrent["precip_in"] as? String ?? ""
            humidity = dictCurrent["humidity"] as? String ?? ""
            cloud = dictCurrent["cloud"] as? String ?? ""
            feelslike_c = dictCurrent["feelslike_c"] as? String ?? ""
            feelslike_f = dictCurrent["feelslike_f"] as? String ?? ""
            vis_km = dictCurrent["vis_km"] as? String ?? ""
            vis_miles = dictCurrent["vis_miles"] as? String ?? ""
            uv = dictCurrent["uv"] as? String ?? ""
            gust_mph = dictCurrent["gust_mph"] as? String ?? ""
            gust_kph = dictCurrent["gust_kph"] as? String ?? ""
        }
        
        struct Condition: Decodable {
            let text: String?
            let icon: String?
            let code: Int?
            
            init (dictCondition: [String: Any]) {
                text = dictCondition["text"] as? String ?? ""
                icon = dictCondition["icon"] as? String ?? ""
                code = dictCondition["code"] as? Int ?? 0
            }
        }
    }

}
