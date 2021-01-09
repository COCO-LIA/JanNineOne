//
//  DetailViewController.swift
//  JanNineOne
//
//  Created by 황현지 on 2021/01/09.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var wvMain: WKWebView!
    
    //5-2
    var url : String? = ""
    var titletext : String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titletext

        let urlAddress = URL(string: url!)
        let request = URLRequest(url: urlAddress!)
        wvMain.load(request)
        
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
