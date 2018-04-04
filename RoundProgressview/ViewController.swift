//
//  ViewController.swift
//  RoundProgressview
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 Abhilash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: RoundProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressView.strokeColor = .red
        progressView.percent = 100
        progressView.fractionColorsEnabled = true
        progressView.fractionColors = [.red,.green,.brown,.cyan]
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.progressView.percent -= 1
            print(self.progressView.percent)
        }
    }
    @IBAction func changeColour(_ sender: Any) {
//        progressView.strokeColor = .green
//        progressView.percent = 100
    }
    
}

