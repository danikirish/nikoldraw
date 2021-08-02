//
//  DrawingViewController.swift
//  nikoldraws
//
//  Created by Daniyar Irishev on 20/07/2021.
//

import UIKit

class DrawingViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var prompt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Prompt details"
    
        label.text = prompt
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteDrawing))
//
    }
    
//    @objc func deleteDrawing(){
        
//        let newCount = count - 1
//
//        UserDefaults().setValue(newCount, forKey: "count")
//        UserDefaults().setValue(nil, forKey: "drawing_\(currentPosition)")
//
//    }


}
