//
//  NetworkingManager.swift
//  weatherApp
//
//  Created by Владислав Лазарев on 29/08/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingManager{
    
    static func fetchData(url: String, completion: @escaping (Weather) -> ()) {
        guard let url = URL(string: url) else { return }
        
        request(url).validate().responseJSON { dataResponse in
            
            switch dataResponse.result {
            case .success(let value):
                let weather = Weather.getWeather(from: value)
                
                DispatchQueue.main.async {
                    completion(weather)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
