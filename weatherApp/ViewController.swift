//
//  ViewController.swift
//  weatherApp
//
//  Created by Владислав Лазарев on 22/08/2019.
//  Copyright © 2019 Владислав Лазарев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let key = "http://api.apixu.com/v1/current.json?key=31fda5124df2479e830165129192308&q="
    var weatherUrl = String()
    
    @IBOutlet var tempretureLabel: UILabel!
    
    @IBOutlet var cityLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}


extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        chechSearchBar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        chechSearchBar()
    }
    
    //Проверка вводимой строки на пустоту
    func chechSearchBar() {
        if searchBar.text == "" {
            showAlert(title: "Ошибка", message: "Введите название города на английском языке")
        } else
        {
            guard let city = searchBar.text else { return }
            weatherUrl = key + city
            fetchData()
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // получение json
    func fetchData() {
        guard let url = URL(string: weatherUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                
                    DispatchQueue.main.async {
                        self.tempretureLabel.text = String(weather.current.temp_c) + "°C"
                        self.cityLabel.text = weather.location.name
                        // Почему не работало такое получение иконки?
                      //  guard let imageUrl = URL(string: weather.current.condition.icon) else { return }
                       // guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                       // self.imageView.image = UIImage(data: imageData)
                    }
                
            } catch let error {
                print(error)
            }
            }.resume() 

    }
}

