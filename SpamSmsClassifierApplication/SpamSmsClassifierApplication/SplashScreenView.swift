//
//  SplashScreenView.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 4/2/23.
//

import SwiftUI

struct SplashScreenView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false // keeps darkmode or lightmode preference store in device
    @State private var SplashFinished = false // keeps track of if splash screen is active
    @State private var size = 0.55 // stores size of image that is displayed on splash screen
    @State private var opacity = 0.5 // stores opacity of image that is displayed on splash screen
    
    var body: some View {
        if SplashFinished { // if the splash screen is over display app
            ContentView().preferredColorScheme(isDarkMode ? .dark : .light) // if darkmode is true display darkmode color scheme if it is false display lightmoode color scheme
        }else{
            ZStack{
                Color.accentColor.ignoresSafeArea()
                VStack{
                    
                    VStack{
                        
                        Image("AiLogo256")
                        Text("SMS Classifier").font(.largeTitle).foregroundColor(Color.white)
                        
                    }.scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){ // causes image to grow and become more visible
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){ // displays splash for 2 seconds before marking splash screen as finished
                        withAnimation{
                            self.SplashFinished = true
                        }
                        
                    }
                }
                
            }
            
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
