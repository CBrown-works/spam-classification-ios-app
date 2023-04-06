//
//  RestApiSpamLogger.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 4/4/23.
//
import Foundation
struct TextClassification: Codable { // creates a model that we are able to decode from json data
    var userId: Int
    var id: Int?
    var title: String // spam
    var text_message: String
}

func postSpam(text_message:String){
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") //access rest api website and prepares url
    
    //guard is used for checking that the optional request exists and exits the current scope if it doesn't
    guard let requestUrl = url else { fatalError() }

    //  prepares the post request from the rest api website
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "POST"

    // then sets the headers for the request
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    //creates an item containing information about the spam text message that will be logged to the server
    let newTextItem = TextClassification(userId: 300, title: "Spam", text_message: text_message)
    // takes the codable structure and encodes it as JSON for request.
    let jsonData = try? JSONEncoder().encode(newTextItem)
    
    request.httpBody = jsonData
        // gets data from rest api website if possible and details any errors that may occur
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            //guard is used for checking that the data exists and exits the current scope if it doesn't
            guard let data = data else {return}

            do{
                // if request was succesful the data is then decoded into a swift structure so that it is accessible and we can verify the data was logged via print
                let TextItemModel = try JSONDecoder().decode(TextClassification.self, from: data)
                print(data)
                print("Response data:\n \(TextItemModel)")
                print("TextItemModel id: \(TextItemModel.id ?? 0)")
                print("TextItemModel uderId: \(TextItemModel.userId)")
                print("TextItemModel Title: \(TextItemModel.title)")
                print("TextItemModel text_message: \(TextItemModel.text_message)")
                
                
            }catch let jsonErr{
                print(jsonErr)
           }

     
    }
    task.resume()

}

