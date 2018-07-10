//
//  ViewController.swift
//  BreakingBadAPIQuoteGenerator
//
//  Created by Lucas Leschynski on 7/10/18.
//  Copyright © 2018 Lucas Leschynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberOfQuotesTextField: UITextField!
    
    let transferClass = InputTransferClass()
    var numberOfQuotesSelected:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onGenerateTapped(_ sender: Any) {
        if numberOfQuotesTextField.text! != "" {
            numberOfQuotesSelected = Int(numberOfQuotesTextField.text!)!
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! QuotesViewController
        dvc.transferClass = self.transferClass
        dvc.transferClass.selectedNumberOfQuotes = self.numberOfQuotesSelected
    }
    
}

