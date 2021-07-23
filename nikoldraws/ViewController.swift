//
//  ViewController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 08/07/2021.
//

import UIKit

class Drawing {
    
    var title: String
    var createdOn: String
    
    init(title: String) {
        self.title = title
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        
        self.createdOn = formatter.string(from: currentDateTime)
    }
    
    
    
}

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    // list of drawings
    var drawings = [Drawing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Drawings"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // First-time setup
        // sets count to 0 and marks as having setup
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // Get all drawings
        updateDrawings()
        
        print(UserDefaults().value(forKey: "setup") as? Bool)
        print(UserDefaults().value(forKey: "count") as? Int)
        print(UserDefaults().value(forKey: "drawing0") as? Drawing)
    }
    
    func updateDrawings() {
        
        drawings.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for x in 0..<count {
            
            if let drawing = UserDefaults().value(forKey: "drawing_\(x+1)") as? Drawing {
                drawings.append(drawing)
            }
            
        }
        
        tableView.reloadData()
        
    }
    
    // Called on button "Add"
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Drawing"
        // prioritise calling updateDrawings()
        vc.update = {
            DispatchQueue.main.async {
                self.updateDrawings()
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
        vc.title = "New Drawing"
        vc.drawing = drawings[indexPath.row]
        // return to root view controller
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let instance = drawings[indexPath.row]
        cell.textLabel?.text = instance.title
        
        return cell
    }
}
