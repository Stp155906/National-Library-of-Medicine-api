// ViewController.swift
// nlmapp
// Created by Shantalia Z on 10/17/23.

import UIKit

// This class represents the main ViewController for the application.
class ViewController: UIViewController, UITableViewDataSource {
    
    // This IBOutlet connects the tableView from the storyboard to the code.
    @IBOutlet weak var tableview: UITableView!
    
    // This array will store the fetched articles from the API.
    var articles: [Article] = []
    
    // This function is called when the view controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[DEBUG] viewDidLoad called")
        
        // Setting the table view's data source to this view controller.
        tableview.dataSource = self
        
        // Fetching articles when the view is loaded.
        fetchArticles()
    }
    
    // This function returns the number of rows in a given section of a table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("[DEBUG] numberOfRowsInSection called. Article count: \(articles.count)")
        return articles.count
    }
    
    // This function returns a cell to insert in a particular location of the table view.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell from the table view.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Get the article corresponding to this row.
        let article = articles[indexPath.row]
        //added this
        cell.textLabel?.text = article.id
        
        print(article)
        
        // TODO: Populate the cell with data from the article.
        // Assuming the cell has a label named titleLabel
        // cell.titleLabel.text = article.title
        
        // Populate the cell with data from the article.
            //cell.titleLabel.text = article.title
        // Make sure your cell has a 'titleLabel' outlet
        //print("Article title: \(article.title)")
        //cell.textLabel?.text = article.title
        

        print("[DEBUG] cellForRowAt called for row: \(indexPath.row)")
        return cell
    }
    
    // This function fetches articles from the provided URL.
    func fetchArticles() {
        print("[DEBUG] fetchArticles started")
        
        // URL string for the API endpoint.
        let urlString = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=limonene"
        
        // Check if the URL string is valid.
        if let url = URL(string: urlString) {
            // Create a shared URL session.
            let session = URLSession.shared
            
            // Create a data task to fetch the data from the URL.
            let task = session.dataTask(with: url) { (data, response, error) in
                
                // Handle any errors.
                if let error = error {
                    print("Error: \(error)")
                    print("[DEBUG] Invalid URL")
                    return
                }
                
                // Handle the received data.
                if let data = data {
                    
                    // Handles data recieved
                    let dataString = String(data: data, encoding: .utf8)
                        print("Received data: \(dataString ?? "Invalid data")")
                    
//                    // Parsing the XML data using the ArticleParser.
//                    let parser = ArticleParser()
//                    self.articles = parser.parse(data: data)
                    
                    
                    
                    
                    
                    // Reload the table view on the main thread since UI updates should be on the main thread.
                    DispatchQueue.main.async {
                        // Parsing the XML data using the ArticleParser.
                        let parser = ArticleParser()
                        self.articles = parser.parse(data: data)
                        
                        self.tableview.reloadData()
                    }
                } else {
                    print("No data received")
                }
            }
            // Start the data task.
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
