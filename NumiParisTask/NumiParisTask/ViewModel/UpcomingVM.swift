//
//  UpcomingVM.swift
//  NumiParisTask
//
//  Created by SWAPNA on 29/03/21.
//

import Foundation
import UIKit

class UpcomingVM {
    
    var resultArray = [DataModel]()
    var id = Int()
    var original_language = String()
    var original_title = String()
    var overview = String()
    var popularity = Int()
    var poster_path = String()
    var release_date = String()
    var titleIS = String()
    var vote_average = Int()
    var vote_count = Int()
   
    func getUpcomingData(completion:@escaping()->()){
        
        if NetworkReachability.isConnectedToNetwork(){
      
        guard let url = URL(string:"https://api.themoviedb.org/3/movie/upcoming?api_key=bac03cef82f59a88f1dcc24500d81de7&language=en-US&page=1") else {
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
                    
                    if let jsonData = json as? [String:AnyObject] {
                        
                        if let data = jsonData["results"] as?  [Dictionary<String, AnyObject>]{
                       
                            for i in data{
                       
                                if let idIS = i["id"] as? Int   {
                                   self.id = idIS
                                }
                                if let orLan = i["original_language"] as? String   {
                                    self.original_language = orLan
                                }
                                if let orTitle = i["original_title"] as? String   {
                                    self.original_title = orTitle
                                }
                                if let overview = i["overview"] as? String   {
                                    self.overview = overview
                                }
                                if let popularity = i["popularity"] as? Int   {
                                   self.popularity = popularity
                                }
                                if let poster_path = i["poster_path"] as? String   {
                                    self.poster_path = poster_path
                                }
                                if let release_date = i["release_date"] as? String   {
                                    self.release_date = release_date
                                }
                                if let vote_average = i["vote_average"] as? Int   {
                                    self.vote_average = vote_average
                                }
                                if let vote_count = i["vote_count"] as? Int   {
                                    self.vote_count = vote_count
                                }
                                if let title = i["title"] as? String   {
                                    self.titleIS = title
                                    
                                }
                                let sampleArray = DataModel(id: self.id, original_language: self.original_language, original_title: self.original_title, overview: self.overview, popularity: self.popularity, poster_path: self.poster_path, release_date: self.release_date, title: self.titleIS, vote_average: self.vote_average, vote_count: self.vote_count)
                                self.resultArray.append(sampleArray)

                            }
                        }
                        print("self.resultArray \(self.resultArray)")
                        completion()
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
        session.resume()
     }else {
            let alert = UIAlertView(title: "No Internet connection", message: "Make sure your device is connected to the internet.", delegate: self, cancelButtonTitle: "Cancel")
            alert.show()
        }
    }
}

// MARK: Activity Loader
func showLoader(view: UIView) -> UIActivityIndicatorView {

        //Customize as per your need
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = UIActivityIndicatorView.Style.white;
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()

        return spinner
    }
extension UIActivityIndicatorView {
     func dismissLoader() {
            self.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
 }
