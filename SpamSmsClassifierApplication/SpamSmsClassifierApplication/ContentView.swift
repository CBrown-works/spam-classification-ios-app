//
//  ContentView.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 3/29/23.
//
import SwiftUI
//enum Theme{
//    static let primary = Color("Background")
//}

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var messageText = ""
    @State var messages: [String] = ["Hello I'm an SMS Text Classifier","I have analyzed thousands of text messages in order to learn how to differentiate between spam text messages and casual conversation","Send me a text message and I'll use my artifical intelligence to determine if the text is spam"]
    @State var about_messages: [String] = ["The collection is composed by just one file, where each line has the correct class (ham or spam) followed by the raw message.","Usage","You can find more useful information about the SMS Spam Collection v.1 at https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection","Finally, we have incorporated the SMS Spam Corpus v.0.1 Big. It has 1,002 SMS ham messages and 322 spam messages and it is public available at: http://www.esp.uem.es/jmgomez/smsspamcorpus/.","A list of 450 SMS ham messages collected from Caroline Tag's PhD Thesis available at http://etheses.bham.ac.uk/253/1/Tagg09PhD.pdf.","A subset of 3,375 SMS randomly chosen ham messages of the NUS SMS Corpus (NSC), which is a dataset of about 10,000 legitimate messages collected for research at the Department of Computer Science at the National University of Singapore. The messages largely originate from Singaporeans and mostly from students attending the University. These messages were collected from volunteers who were made aware that their contributions were going to be made publicly available. The NUS SMS Corpus is avalaible at: http://www.comp.nus.edu.sg/~rpnlpir/downloads/corpora/smsCorpus/.","A collection of 425 SMS spam messages was manually extracted from the Grumbletext Web site. This is a UK forum in which cell phone users make public claims about SMS spam messages, most of them without reporting the very spam message received. The identification of the text of spam messages in the claims is a very hard and time-consuming task, and it involved carefully scanning hundreds of web pages. The Grumbletext Web site is: http://www.grumbletext.co.uk/.","This corpus has been collected from free or free for research sources at the Internet:","Composition","The SMS Spam Collection v.1 is a public set of SMS labeled messages that have been collected for mobile phone spam research. It has one collection composed by 5,574 English, real and non-enconded messages, tagged according being legitimate (ham) or spam.","The SMS Spam Collection was created by Tiago A. Almeida and José María Gómez Hidalgo."]
    @State var HamOrSpam: Bool = false
    
    var platforms: [Platform] = [.init(name: "Spam SMS Classification",
                                       imageName:"text.bubble.fill",color:.pink),
                                 .init(name: "About The Data", imageName:"doc.plaintext",color:.green),
                                 .init(name: "Settings", imageName:"gearshape",color:.gray),

    ]
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{
                List {
                    Section("MENU") {
                        ForEach(platforms, id: \.name) { platform in
                            NavigationLink(value: platform) {
                                Label(platform.name, systemImage: platform.imageName)
                                    .foregroundColor(platform.color)
                            }
                        }
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for:Platform.self ) { platform in
                    if platform.name == "Spam SMS Classification"{
                        VStack{
                            HStack{
                                
                                Text("SMS Classifier").font(.largeTitle).bold()
                                Image("AiLogo100")
                            }
                            ScrollView{
                                ForEach(messages, id: \.self){ message in
                                    if message.contains("[USER]"){
                                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                                        HStack{
                                            Spacer()
                //                            ChatBubble(direction: .right) {
                //                                Text(newMessage)
                //                                .padding(.all, 20)
                //                                .foregroundColor(Color.white)
                //                                .background(Color.blue)
                //
                //                            }
                //
                                            Text(newMessage)
                                                .padding()
                                                .foregroundColor(Color.white)
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .padding(.horizontal, 16)
                                                .padding(.bottom, 10)
                                            
                                        }
                                    }else{
                                        HStack {
                //                            ChatBubble(direction: .left) {
                //                            Text(message)
                //                            .padding(.all, 15)
                //                            .foregroundColor(Color.black)
                //                            .background(Color.gray.opacity(0.15))
                //                            }
                                            
                                            Text(message)
                                                .padding()
                                                .background(Color.gray.opacity(0.15))
                                                .cornerRadius(10)
                                                .padding(.horizontal, 16)
                                                .padding(.bottom, 10)
                                            Spacer()
                                                }
                                    }
                                }.rotationEffect(.degrees(180))
                            }.rotationEffect(.degrees(180))
                                .background(Color.gray.opacity(0.10))
                            HStack{
                                TextField("Type something", text: $messageText).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                                    .onSubmit {
                                    sendMessage(message: messageText)
                                }
                                Button{
                                    sendMessage(message: messageText)
                                }label: {
                                    Image(systemName: "paperplane.fill")
                                }.font(.system(size: 26)).padding(.horizontal,10)
                            }.padding()
                        }
                        
                    }
                    else if platform.name == "About The Data"{
                        VStack{
                            HStack{
                                
                                Text("About The Data").font(.largeTitle).bold()
                                Image("AiLogo100")
                            }
                            ScrollView{
                                HStack {
    
                                    Image("dataExample")
                                        .padding()
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }.rotationEffect(.degrees(180))
                                
                                ForEach(about_messages, id: \.self){ message in
                                    HStack {
    
                                        Text(message)
                                            .padding()
                                            .background(Color.gray.opacity(0.15))
                                            .cornerRadius(10)
                                            .padding(.horizontal, 16)
                                            .padding(.bottom, 10)
//                                        ChatBubble(direction: .left) {
//                                            Text(message)
//                                            .padding(.all, 15)
//                                            .foregroundColor(Color.black)
//                                            .background(Color.gray.opacity(0.15))
//
//                                        }
                                        Spacer()
                                    }.rotationEffect(.degrees(180))
                                }
                                HStack {
    
                                    Image("uciML")
                                        .padding()
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }.rotationEffect(.degrees(180))

                                
                                
                            }.rotationEffect(.degrees(180))
                                .background(Color.gray.opacity(0.10))
                            
                        }
                        
                    }
                    else if platform.name == "Settings"{
                        VStack{
                            Picker("Mode", selection: $isDarkMode){
                                Text("Light").tag(false)
                                Text("Dark").tag(true)
                            }.pickerStyle(SegmentedPickerStyle())
                        }.padding()
                        List(0..<5, id: \.self){ num in
                            Text("\(num)")
                            
                        }
                        
                    }
                    else{
                        ZStack{
                            platform.color.ignoresSafeArea()
                            Label(platform.name, systemImage: platform.imageName)
                                .font(.largeTitle).bold()
                        }
                        
                    }
                    
                }
            }
            
        } else {
            // Fallback on earlier versions
        }
    }
    func sendMessage(message:String){
        withAnimation{
            messages.append("[USER]" + message)
            self.messageText = ""
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            withAnimation(){
                
                let classVal = getAIReponse(message: message)!.label
                if classVal == "ham"{
                    messages.append("That text message is most likely not spam")
                    
                    
                }else{
                    messages.append("That text message is most likely spam")
                    
                }
                
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Platform : Hashable {
    let name: String
    let imageName: String
    let color: Color
}
