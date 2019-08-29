//
//  UIImageView + Extension.swift
//  weatherApp
//
//  Created by Владислав Лазарев on 28/08/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func dowlandImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        _ = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
            }.resume
    }
    
}
