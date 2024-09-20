//
//  NetworkManager.swift
//  ArtApp
//
//  Created by Кирилл Бахаровский on 9/21/24.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchData(from urlString: String, completion: @escaping ([Artist]?) -> Void) {
        // Проверяем правильность URL
        guard let url = URL(string: urlString) else {
            print("Ошибка: Некорректный URL")
            completion(nil)
            return
        }
        
        // Создаём сессию для получения данных
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка сети: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Проверяем, что данные существуют
            guard let data = data else {
                print("Ошибка: Нет данных")
                completion(nil)
                return
            }
            // Декодируем данные
            do {
                let decodedData = try JSONDecoder().decode(Artists.self, from: data)
                completion(decodedData.artists)
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

