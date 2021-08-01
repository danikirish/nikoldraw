//
//  PromptController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 30/07/2021.
//

import UIKit

class PromptController: ObservableObject {
    @Published var words: [String]
    @Published var prompts: [String]
    
    init() {
        
        self.words = ["dog", "cat", "racoon", "rat", "alpaca", "kitten", "puppy", "moon", "coffee", "tea", "parchute", "cactus", "houseplant", "sun", "hat", "airplane", "door", "portal", "skyscraper", "magazine", "letter", "book", "nature", "feather", "dragon", "camera", "forest", "bubbles", "idea", "memory", "fairytale", "anxiety", "pressure", "dream", "hope", "desire", "love", "sadness", "opportunity", "work", "madness", "cravings", "mystery", "childhood", "freedom", "energy", "achievement", "perspective",
                              "round", "tiny", "magenta", "purple", "grey", "huge", "long", "short", "pink", "blue", "fucsia", "solid", "chunky", "fluffy", "soft", "transparent", "sweet", "cold", "dangerous", "lovely", "tiresome", "revengeful", "horny", "beautiful", "melancholic", "joyful", "electric", "awesome", "terrible", "exhausted", "listless", "mysterious", "intangible", "delirious", "dazed", "sleepy", "happy", "injured",
                              "running", "working", "playing", "dancing", "going", "disappearing", "smiling", "falling", "jumping", "reading", "writing", "flying", "laughing", "crawling", "crying", "fighting"
                          ]
//
//        self.prompts = ["test"]
        self.prompts = []
        
//        loadData()
        print("The prompts that I have are: \(self.prompts)")
        
    }
    
    func addPrompt(newPrompt: String) {
        self.prompts.append(newPrompt)
        print("New prompt created")
    }
    
    func addPrompts(newPrompts: [String]) {
        self.prompts.append(contentsOf: newPrompts)
    }
    
    func generatePrompt(length: Int) -> String {
        let chosenWords = self.words.shuffled().prefix(length)
        
        let generatedPrompt = chosenWords.joined(separator: " ")
        
        print("Generated: \(generatedPrompt)")
        return generatedPrompt
    }
    
//    func loadData() {
//        if let path = Bundle.main.path(forResource: "Prompts", ofType: "json") {
//            var promptsArray = try! JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: path)), options: JSONSerialization.ReadingOptions()) as? [Any]
//
//            var finalArray:[String] = []
//
//            for promptDict in promptsArray! {
//                if let dict = promptDict as? [String: Any], let promptArray = dict["prompts"] as? [String] {
//                    finalArray.append(contentsOf: promptArray)
//                }
//            }
//
//            print("The data that I parsed is: \(finalArray)")
//            self.prompts = finalArray
//        } else {
//            print("Couldn't parse")
//        }
        
        
        
        
//    }
    
    
//    func loadData() {
//
//        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
//        let data = try! Data(contentsOf: url)
//        do {
//            let promptData = try JSONDecoder().decode(PromptData.self, from: data)
//            DispatchQueue.main.async {
//                self.prompts = promptData.existing
//                self.categories = promptData.categories
//            }
//        } catch {
//            print(error)
//        }
//    }
}


struct PromptData: Decodable {
    let words: [String]
    let prompts: [String]
}
