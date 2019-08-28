//
//  ViewController.swift
//  weatherApp
//
//  Created by Владислав Лазарев on 22/08/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let key = "http://api.apixu.com/v1/current.json?key=31fda5124df2479e830165129192308&q="
    var weatherUrl = ""
    
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var tempretureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        checkSearchBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        fetchDataWithAlamofire()
    }
    
    //Проверка вводимой строки на пустоту
    func checkSearchBar() {
        if searchBar.text == "" {
            showAlert(title: "Ошибка", message: "Введите название города на английском языке")
        } else {
            guard let city = searchBar.text else { return }
            weatherUrl = key + city
            fetchDataWithAlamofire()
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // parsing with URLsession
    func fetchData() {
        guard let url = URL(string: weatherUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                
                    DispatchQueue.main.async {
                        guard let temp = weather.current?.temp_c else { return }
                        self.tempretureLabel.text = "\(temp)°C"
                        self.cityLabel.text = weather.location?.name
                        guard let imageStr = weather.current?.condition?.icon else {return}
                        self.imageView.dowlandImage(from: imageStr)
                        self.conditionLabel.text = weather.current?.condition?.text
                    }
                
            } catch let error {
                print(error)
            }
            }.resume() 

    }
    
    //parsing with alamofire
    func fetchDataWithAlamofire() {
        guard let url = URL(string: weatherUrl) else { return }
        
        request(url).validate().responseJSON { dataResponse in
            
            switch dataResponse.result {
            case .success(let value):
                let weather = Weather.getWeather(from: value)
                DispatchQueue.main.async {
                    guard let temp = weather.current?.temp_c else { return }
                    self.tempretureLabel.text = "\(temp)°C"
                    self.cityLabel.text = weather.location?.name
                    guard let imageStr = weather.current?.condition?.icon else {return}
                    self.imageView.dowlandImage(from: imageStr)
                    self.conditionLabel.text = weather.current?.condition?.text
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

