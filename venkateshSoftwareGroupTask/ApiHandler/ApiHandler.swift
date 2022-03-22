//
//  ApiHandler.swift
//  venkateshSoftwareGroupTask
//
//  Created by venkatesh prasad on 21/03/22.
//

import UIKit

class ApiHandler{
    static let shared = ApiHandler()
    
    func getApiCall<T:Codable>(urlstr:String,city:String,completion: @escaping (_ success:T?,_ err: Error?) -> Void){
        guard let url = URL(string: urlstr + "&q=\(city)&key=\(WeatherApiKey.apiKey)") else { return }
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil,error)
                return
            }
            
            do{
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result,nil)
            } catch let errr{
                completion(nil,errr)
            }
        }.resume()
    }
    
}
