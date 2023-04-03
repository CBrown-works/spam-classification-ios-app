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
        return prediction

    } catch{

    }
    return nil
    
}

