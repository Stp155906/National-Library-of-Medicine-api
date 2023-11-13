//
//  EfetchManager.swift
//  nlmapp
//
//  Created by Shantalia Z on 11/7/23.
//



import Foundation

// A manager responsible for fetching detailed article information from NCBI.
class EFetchManager {

    // Function to fetch articles by ID and return a completion handler with an array of Articles.
    func fetchArticles(ids: [String], completion: @escaping ([Article]) -> Void) {
        // Construct the URL for eFetch with parameters for detailed information.
        let idParameter = ids.joined(separator: ",")
        guard let url = URL(string: "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pubmed&id=\(idParameter)&retmode=xml&rettype=abstract") else {
            print("Invalid URL")
            return
        }
        
        // Start a data task to fetch the articles.
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle errors.
            if let error = error {
                print("Error fetching articles: \(error)")
                return
            }
            
            // Ensure data is not nil.
            guard let data = data else {
                print("No data returned from eFetch.")
                return
            }
            
            // Parse the XML data using the ArticleParser.
            let parser = XMLParser(data: data)
            let articleParser = ArticleParser()  // Using the updated ArticleParser.
            parser.delegate = articleParser
            parser.parse()
            
            // Once parsing is complete, call the completion handler with the parsed articles.
            DispatchQueue.main.async {
                completion(articleParser.articles)
            }
        }
        
        // Resume the task to start the request.
        task.resume()
    }
}
