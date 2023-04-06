//
//  ContentView.swift
//  SpamSmsClassifierApplication
//
//  Created by Carlton Brown on 3/29/23.
//
import SwiftUI
struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false  // used to store boolean property that determine if dark mode is on for visuals, saves this property to device so that the choice of dark mode or light mode is remembered/saved after user closes app
    
    @State private var messageText = "" // temporarily stores text from users or AI before being added to messages array
    
    @State var messages: [String] = ["Hello I'm an SMS Text Classifier","I have analyzed thousands of text messages in order to learn how to differentiate between spam text messages and casual conversation","Send me a text message and I'll use my artificial intelligence to determine if the text is spam"]// stores messages between users and AI before pushinng them to user interface
    
    @State var about_messages: [String] = ["The collection is composed by just one file, where each line has the correct class (ham or spam) followed by the raw message.","Usage","You can find more useful information about the SMS Spam Collection v.1 at https://archive.ics.uci.edu/ml/datasets/SMS+Spam+Collection","Finally, we have incorporated the SMS Spam Corpus v.0.1 Big. It has 1,002 SMS ham messages and 322 spam messages and it is public available at: http://www.esp.uem.es/jmgomez/smsspamcorpus/.","A list of 450 SMS ham messages collected from Caroline Tag's PhD Thesis available at http://etheses.bham.ac.uk/253/1/Tagg09PhD.pdf.","A subset of 3,375 SMS randomly chosen ham messages of the NUS SMS Corpus (NSC), which is a dataset of about 10,000 legitimate messages collected for research at the Department of Computer Science at the National University of Singapore. The messages largely originate from Singaporeans and mostly from students attending the University. These messages were collected from volunteers who were made aware that their contributions were going to be made publicly available. The NUS SMS Corpus is avalaible at: http://www.comp.nus.edu.sg/~rpnlpir/downloads/corpora/smsCorpus/.","A collection of 425 SMS spam messages was manually extracted from the Grumbletext Web site. This is a UK forum in which cell phone users make public claims about SMS spam messages, most of them without reporting the very spam message received. The identification of the text of spam messages in the claims is a very hard and time-consuming task, and it involved carefully scanning hundreds of web pages. The Grumbletext Web site is: http://www.grumbletext.co.uk/.","This corpus has been collected from free or free for research sources at the Internet:","Composition","The SMS Spam Collection v.1 is a public set of SMS labeled messages that have been collected for mobile phone spam research. It has one collection composed by 5,574 English, real and non-enconded messages, tagged according being legitimate (ham) or spam.","The SMS Spam Collection was created by Tiago A. Almeida and José María Gómez Hidalgo."] // used just to store messages telling the user what the data is about before pushing the messages to ui
    
    var pages: [Page] = [.init(name: "Spam SMS Classification",
                                       imageName:"text.bubble.fill",color:.pink),
                                 .init(name: "About The Data", imageName:"doc.plaintext",color:.green),
                                 .init(name: "Settings", imageName:"gearshape",color:.gray),] // array that stores properties of each page within app
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack{ // provides foundation for navigation among pages within app
                List { // holds each page within a section that allows user to click labels to navigate
                    Section("MENU") {
                        ForEach(pages, id: \.name) { page in
                            NavigationLink(value: page) {// makes a link that allows labels to be able to navigate back and forth through app
                                Label(page.name, systemImage: page.imageName)
                                    .foregroundColor(page.color)
                            }
                        }
                    }
                }
                .navigationTitle("Home")
                .navigationDestination(for:Page.self ) { page in
                    if page.name == "Spam SMS Classification"{// when a user clicks a label from the section the if statements determine which page to display based on label name clicked
                        VStack{ 
                            HStack{
                                Text("SMS Classifier").font(.largeTitle).bold()
                                Image("AiLogo100")
                            }
                            ScrollView{
                                ForEach(messages, id: \.self){ message in // iterates through messages array to display message in ui
                                    if message.contains("[SELF]"){ //used to distinguish text message from user an AI , if the text is from user it will be placed on right side of screen
                                        let newMessage = message.replacingOccurrences(of: "[SELF]", with: "") // removes label from user text before displaying
                                        HStack{
                                            Spacer()
                                            Text(newMessage)
                                                .padding()
                                                .foregroundColor(Color.white)
                                                .background(Color.blue.opacity(0.8))
                                                .cornerRadius(10)
                                                .padding(.horizontal, 16)
                                                .padding(.bottom, 10)
                                        }
                                    }else{ // if the message isnt from the user then display text on left side of screen
                                        HStack {
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
                            }.rotationEffect(.degrees(180)) // the double rotation effects flips messages to make messages display from bottom to top
                                .background(Color.gray.opacity(0.10))
                            HStack{
                                TextField("Type something....", text: $messageText).padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                                    .onSubmit { // stores user text to binding variable then uses send message method to push to array and display in UI after user presses enter
                                    sendMessage(message: messageText)
                                }
                                Button{
                                    sendMessage(message: messageText) // allows user to press button to send the typed text message
                                }label: {
                                    Image(systemName: "paperplane.fill")
                                        
                                }.font(.system(size: 26)).padding(.horizontal,10)
                            }.padding()
                        }
                    }
                    else if page.name == "About The Data"{
                        VStack{
                            HStack{
                                Text("About The Data").font(.largeTitle).bold()
                                Image("AiLogo100")
                            }
                            ScrollView{
                                
                                HStack {
                                    Image("data_example")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding()
                                        .background(Color.gray.opacity(0.15))
                                        .cornerRadius(10)
                                        .padding(.horizontal, 16)
                                        .padding(.bottom, 10)
                                    Spacer()
                                }.rotationEffect(.degrees(180))
                                ForEach(about_messages, id: \.self){ message in
                                    HStack {
                                        Text(message).textSelection(.enabled)
                                            .padding()
                                            .background(Color.gray.opacity(0.15))
                                            .cornerRadius(10)
                                            .padding(.horizontal, 16)
                                            .padding(.bottom, 10)
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
                    else if page.name == "Settings"{
                        VStack{
                            Picker("Mode", selection: $isDarkMode){ // allows user to toggle darkmode for the app on and off
                                Text("Light").tag(false)
                                Text("Dark").tag(true)
                            }.pickerStyle(SegmentedPickerStyle())
                        }.padding()
                        Spacer()
                        if isDarkMode == true{ // displays a sun or moon image if dark mode is on or off
                            Image("moon")
                            Spacer()
                        }else{
                            Image("sun")
                            Spacer()
                        }
                    }
//                    else{
//                        ZStack{
//                            page.color.ignoresSafeArea()
//                            Label(page.name, systemImage: page.imageName)
//                                .font(.largeTitle).bold()
//                        }
//                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    func sendMessage(message:String){ // method for sending messages and determining if the user submmited text message is spam or not
        withAnimation{
            messages.append("[SELF]" + message) // adds a label to messages sent from user so that UI knows which side to place user message on screen
            self.messageText = "" // then it erases data in text box now that message is sent
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1){ // delays ai response by one second
            withAnimation(){
                let classVal = getAIReponse(message: message)!.label // creates a variable that sends the text message to the AI and stores the prediction response from AI that will either be ham or spam
                if classVal == "ham"{
                    messages.append("That text message is most likely not spam ✅ 👍")
                }else{
                    messages.append("That text message is most likely spam 🗑️👎")
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
struct Page : Hashable { // values passed into naviation stack must be hashable so a hashable page structure is created containing properties that confrom to hashble is is used. hasables are just a type that can be hashed into a Hasher to produce an integer hash value.
    let name: String
    let imageName: String
    let color: Color
}
