//
//  Ai_Reponse.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 3/29/23.
//

import Foundation
import CoreML

func getAIReponse(message: String) -> SpamSmsClassifierOutput?{ // method for taking input and returning a ham or spam response
    let tempMessage = message.lowercased()
    
    do {
        let config = MLModelConfiguration() // the basic settings for creating or updating a machine learning model.
        let model = try SpamSmsClassifier(configuration: config) // creates an instance of the AI model

        let prediction = try model.prediction(input:SpamSmsClassifierInput.init(text: tempMessage))
        
        let classVal = prediction.label // creates a variable that sends the text message to the AI and stores the prediction response from AI that will either be ham or spam
        if classVal == "spam"{
            postSpam( text_message: message)// if the message is spam post the spam text to rest api to simulate logging spam messages
        }
        
        return prediction
        
        

    } catch{

    }
    return nil
    
}

