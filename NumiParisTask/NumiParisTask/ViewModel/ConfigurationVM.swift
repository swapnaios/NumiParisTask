//
//  ConfigurationVM.swift
//  NumiParisTask
//
//  Created by SWAPNA on 29/03/21.
//

import Foundation
import UIKit

class ConfigurationVM {
    
    var secureImageBaseURL = String()
    var imageURL = String()
    var size = String()

    func getConfigurationData(completion:@escaping()->()){
        
          guard let url = URL(string: "https://api.themoviedb.org/3/configuration?api_key=bac03cef82f59a88f1dcc24500d81de7") else {
            return
        }
        
        let headers = ["Authorization": "bac03cef82f59a88f1dcc24500d81de7"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        print("url is \(url)")
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                                    
            guard let mdata = data else {return}
                do {
                   let json = try JSONSerialization.jsonObject(with: mdata, options: [])
                    
                    print("json is \(json)")
             
                    if let jsonData = json as? [String:AnyObject] {
                        print("json is \(json)")
                        
                      if let data = jsonData["images"] {
                            print("data is \(data)")

                            if let secureBaseURL = data["secure_base_url"] as? String {
                                
                                self.imageURL = secureBaseURL
                            }
                            if let poster_sizes = data["poster_sizes"] as? Array<Any> {
                    
                                self.size = poster_sizes[1] as! String
                            }
                            self.secureImageBaseURL = self.imageURL + self.size
                            print("secureBaseURL is \(self.secureImageBaseURL)")
                            completion()
                        }
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
        session.resume()

    }
}
