//
//  ViewController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 08/07/2021.
//

import UIKit

class ViewController: UIViewController {

    /*
     --- Start generator here ---
     */
    
    var promptController = PromptController()
    
    /*
     --- End generator here ---
     */
    
    @IBOutlet var tableView: UITableView!
    // list of drawings
    var prompts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Prompts"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // First-time setup
        // sets count to 0 and marks as having setup
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // Get all drawings
        updatePrompts()
    }
    
    func updatePrompts() {
        
        prompts.removeAll()
//        words.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }

        for x in 0..<count {

            if let prompt = UserDefaults().value(forKey: "prompt_\(x+1)") as? String {
                prompts.append(prompt)
            }

        }
        
//        prompts = promptController.prompts
        
        tableView.reloadData()
        
    }
    
    // Called on button "Generate"
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Prompt"
        vc.promptController = self.promptController
        // prioritise calling updatePrompts()
        vc.update = {
            DispatchQueue.main.async {
                self.updatePrompts()
            }
        }
        // go to entry view controller
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    
        let vc = storyboard?.instantiateViewController(identifier: "drawing") as! DrawingViewController
        vc.title = "New Prompt"
        vc.prompt = prompts[indexPath.row]
        // return to root view controller
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prompts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = prompts[indexPath.row]
        
        return cell
    }
}
