//
//  TopRatedViewController.swift
//  NumiParisTask
//
//  Created by SWAPNA on 29/03/21.
//

import UIKit

class TopRatedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var topRatedVM = TopRatedVM()
    var configVMObject = ConfigurationVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show activity loader
        let spinner = showLoader(view: self.view)
        self.topRatedVM.getTopRatedData() {
            
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
extension TopRatedViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topRatedVM.resultArray.count
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "topRatedCell") as! TopRatedCell

        cell.lblTitle.text = self.topRatedVM.resultArray[indexPath.row].title
        
        DispatchQueue.main.async {
            let posterPath = self.topRatedVM.resultArray[indexPath.row].poster_path
            
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
        detailVC?.id = self.topRatedVM.resultArray[indexPath.row].id
        detailVC?.original_language = self.topRatedVM.resultArray[indexPath.row].original_language
        detailVC?.titleIS = self.topRatedVM.resultArray[indexPath.row].title
        detailVC?.overview = self.topRatedVM.resultArray[indexPath.row].overview
        detailVC?.popularity = self.topRatedVM.resultArray[indexPath.row].popularity
        detailVC?.release_date = self.topRatedVM.resultArray[indexPath.row].release_date
        detailVC?.vote_count = self.topRatedVM.resultArray[indexPath.row].vote_count
        detailVC?.vote_average = self.topRatedVM.resultArray[indexPath.row].vote_average
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
}
