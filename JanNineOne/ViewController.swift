//
//  ViewController.swift
//  JanNineOne
//
//  Created by 황현지 on 2021/01/09.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //2 데이터 함수 입력
        getData()
    }

    //1번 데이터 함수 생성
    func getData() {
        
        let articleUrl = URL(string: "http://newsapi.org/v2/everything?q=bitcoin&from=2020-12-09&sortBy=publishedAt&apiKey=f1c87e2bb86248de9f9492e513f93e1f")
        let request = URLRequest(url: articleUrl!)
        
        AF.request(request).responseData { (data) in
            if data.error != nil {
                return print("err", data.error?.localizedDescription)
            }
            
//            print("-------",data.data)
            self.articles = self.parseJsonData(origindata: data.data!)
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
        
            }
        }.resume()
    }
    
    
    func parseJsonData(origindata: Data) -> [Article] {
        self.articles = [Article]()
        
        let decoder = JSONDecoder()
        
        do {
            let articleDataStore = try decoder.decode(ArticleDataStore.self, from: origindata)
//            print("----", articelDataStore.articles)
            articles = articleDataStore.articles
            
        } catch {
            print(error)
        }
        return articles
    }
    
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        if identifier == "toDetail" {

//        }
//        
//    }
    //5-1.화면이동해주는 세그
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        let indexpath = self.tableView.indexPathForSelectedRow
        let indexUrl = articles[indexpath!.row].url
        let indexTitle = articles[indexpath!.row].title
        
        vc.url = indexUrl
        vc.titletext = indexTitle
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cell1
        
        cell1.authorLabel.text = articles[indexPath.row].author
        cell1.titleLabel.text = articles[indexPath.row].title
        cell1.descriptionLabel.text = articles[indexPath.row].description
        
        cell1.imgView.kf.setImage(with: URL(string: articles[indexPath.row].urlToImage!))

            
        
        
        return cell1
    }
    
    
}

