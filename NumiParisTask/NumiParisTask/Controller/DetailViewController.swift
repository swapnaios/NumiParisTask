//
//  DetailViewController.swift
//  NumiParisTask
//
//  Created by SWAPNA on 29/03/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblPopularity: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var lblVoteAverage: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var id = Int()
    var original_language = String()
    var overview = String()
    var popularity = Int()
    var poster_path = String()
    var release_date = String()
    var titleIS = String()
    var vote_average = Int()
    var vote_count = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblTitle.text = titleIS
        self.lblLanguage.text = original_language
        self.lblID.text = "\(id)"
        self.lblPopularity.text = "\(popularity)"
        self.lblVoteCount.text = "\(vote_count)"
        self.lblVoteAverage.text = "\(vote_average)"
        self.lblOverview.text = overview
        
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
