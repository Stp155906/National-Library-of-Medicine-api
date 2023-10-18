//
//  ViewController.swift
//  nlmapp
//
//  Created by Shantalia Z on 10/17/23.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var articles: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        fetchArticles()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
        
        _ = articles[indexPath.row]
        // TODO: Set up cell based on the article data
        // e.g. cell.label.text = article.title
        
        return cell
    }
    
    func fetchArticles() {
        let urlString = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=limonene"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    // Just printing the XML here, you need to actually parse this XML to populate your articles
                    if let xmlString = String(data: data, encoding: .utf8) {
                        print("XML Response: \(xmlString)")
                    } else {
                        print("Invalid XML data")
                    }
                } else {
                    print("No data received")
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
