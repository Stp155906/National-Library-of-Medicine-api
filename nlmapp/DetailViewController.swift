// DetailViewController.swift
// nlmapp

import UIKit

class DetailViewController: UIViewController {
    
    // Add outlets for the UI elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publicationDate: UILabel!
    // Add properties to hold the details that will be passed from the ViewController
    // Properties to hold the details that will be passed from the ViewController
        var articleTitle: String?
        var articleAbstract: String?
        var authors: String? // You need to declare this if you want to display authors
        var publicationDateString: String?  // Renamed property for clarity
    
    // Property to hold the selected article ID
        var selectedArticleId: String?

        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Fetch and parse detailed data
                    if let articleId = selectedArticleId {
                        fetchAndDisplayArticleDetails(articleId)
                    }

            
            // Set the UI elements with the article details
            
                    titleLabel.text = articleTitle
                    abstractTextView.text = articleAbstract
                    authorsLabel.text = authors
                    publicationDate.text = publicationDateString
        }
    
    private func fetchAndDisplayArticleDetails(_ articleId: String) {
            EFetchManager().fetchArticles(ids: [articleId]) { [weak self] articles in
                guard let self = self, let article = articles.first else { return }
                // Assuming Article structure has properties like title, abstract, etc.
                self.titleLabel.text = article.title
                self.abstractTextView.text = article.abstract
                self.authorsLabel.text = article.authors?.joined(separator: ", ")
                self.publicationDate.text = article.publicationDate // Format date as needed
            }
        }

}


