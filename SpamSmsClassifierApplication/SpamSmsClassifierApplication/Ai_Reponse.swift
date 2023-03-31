//
//  Ai_Reponse.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 3/29/23.
//

import Foundation
import CoreML

func getAIReponse(message: String) -> SpamSmsClassifierOutput?{
    let tempMessage = message.lowercased()
    
    do {
        let config = MLModelConfiguration()
        let model = try SpamSmsClassifier(configuration: config)

        let prediction = try model.prediction(input:SpamSmsClassifierInput.init(text: tempMessage))
        return prediction

    } catch{

    }
    return nil
    
}

