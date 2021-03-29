//
//  UpcomingViewController.swift
//  NumiParisTask
//
//  Created by SWAPNA on 29/03/21.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var upcomingVMObject = UpcomingVM()
    var configVMObject = ConfigurationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show activity loader
        let spinner = showLoader(view: self.view)
        self.upcomingVMObject.getUpcomingData() {
            
            self.configVMObject.getConfigurationData() {
                //Hide activity loader
                spinner.dismissLoader()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcomingVMObject.resultArray.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell") as! UpcomingCell
        
        cell.lblTitle.text = self.upcomingVMObject.resultArray[indexPath.row].title
        cell.lblVoteCount.text = "\(self.upcomingVMObject.resultArray[indexPath.row].vote_count)"
        
        DispatchQueue.main.async {
        let posterPath = self.upcomingVMObject.resultArray[indexPath.row].poster_path
        
        let finalURLPath = self.configVMObject.secureImageBaseURL + posterPath
        
        let urlObj = URL(string: finalURLPath)

       if urlObj != nil {
        if  let myData = NSData(contentsOf: urlObj!) {
            cell.imgPicture.image = UIImage(data: myData as Data)
        }
      }
        }
          return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "detailViewController") as? DetailViewController
        detailVC?.id = self.upcomingVMObject.resultArray[indexPath.row].id
        detailVC?.original_language = self.upcomingVMObject.resultArray[indexPath.row].original_language
        detailVC?.titleIS = self.upcomingVMObject.resultArray[indexPath.row].title
        detailVC?.overview = self.upcomingVMObject.resultArray[indexPath.row].overview
        detailVC?.popularity = self.upcomingVMObject.resultArray[indexPath.row].popularity
        detailVC?.release_date = self.upcomingVMObject.resultArray[indexPath.row].release_date
        detailVC?.vote_count = self.upcomingVMObject.resultArray[indexPath.row].vote_count
        detailVC?.vote_average = self.upcomingVMObject.resultArray[indexPath.row].vote_average
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
}
