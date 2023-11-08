//
//  ArticleParser.swift
//  nlmapp

// The ArticleParser class which implements the XMLParserDelegate and is responsible for parsing the XML data to create Article objects.
//  Created by Shantalia Z on 10/18/23.
//

import Foundation

// ArticleParser is a class responsible for parsing XML data to retrieve article information.
class ArticleParser: NSObject, XMLParserDelegate {
    
    // An array to hold the articles parsed from the XML.
    var articles: [Article] = []
    
    // Keep track of the current XML element being parsed.
    var currentElement: String = ""
    
    // A string to hold the characters found within an XML element.
    var foundCharacters: String = ""
    
    // A temporary object to hold data for a currently-being-parsed article.
    var currentArticle: Article? = nil  // Assuming Article is a struct/class you've defined earlier

    // Parses XML data and returns an array of Article objects.
    func parse(data: Data) -> [Article] {
        let parser = XMLParser(data: data)  // Initialize an XML parser with the given data.
        parser.delegate = self              // Set the parser's delegate to this class.
        parser.parse()                      // Start parsing.
        return articles                     // Return the parsed articles.
    }
    
    // MARK: - XMLParserDelegate methods

    // Called when the parser encounters the beginning of an element.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "Id" { // You are interested in Id elements.
            // Reset the characters.
            foundCharacters = ""
        }
    }
    
    // Called when the parser encounters character data inside an element.
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // Append the character data to the foundCharacters string.
        // This data could be split across multiple calls, so we build it up over time.
        foundCharacters += string
    }
    
    // Called when the parser encounters the end of an element.
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Id" { // End of Id element.
            // Trim whitespace and newline characters from the found characters.
            
            
            let trimmedString = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            // If it's non-empty, create an article with the ID.
            if !trimmedString.isEmpty {
                
                print(trimmedString)
                let article = Article(id: trimmedString, title: "", authors: [], abstract: "")
                articles.append(article)
            }
            // Reset the foundCharacters for the next element.
            foundCharacters = ""
        }
    }
    
    // Called by the parser when it starts parsing the document.
    func parserDidStartDocument(_ parser: XMLParser) {
        articles = [] // Reset the articles array when a new parse begins.
    }
    
    // Called by the parser when it has successfully completed parsing.
    func parserDidEndDocument(_ parser: XMLParser) {
        // Parsing is done, do any cleanup or finalization here.
    }
    
    // Called by the parser when it encounters an error.
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("XML Parse error: \(parseError.localizedDescription)")
    }
}
