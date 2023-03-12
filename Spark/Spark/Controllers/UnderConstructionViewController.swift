//
//  UnderConstructionViewController.swift
//  Spark
//
//  Created by Ratcha Mahesh Babu on 11/03/23.
//

import UIKit

class UnderConstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        revealViewController()?.revealSideMenu()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
