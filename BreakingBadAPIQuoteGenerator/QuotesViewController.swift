//
//  QuotesViewController.swift
//  BreakingBadAPIQuoteGenerator
//
//  Created by Lucas Leschynski on 7/10/18.
//  Copyright © 2018 Lucas Leschynski. All rights reserved.
//

import UIKit

class QuotesViewController: UITableViewController {
    
    var transferClass = InputTransferClass()
    var quotes = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.transferClass.selectedNumberOfQuotes)
        self.title = "Generated Ron Swanson Quotes"
        // Do any additional setup after loading the view.
        let query = "https://ron-swanson-quotes.herokuapp.com/v2/quotes/\(transferClass.selectedNumberOfQuotes)"
        print(query)
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                        self.parse(json: json)
                        return
                }
            }
            self.loadError()
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parse(json: JSON) {
        for i in json[].arrayValue {
            let quote = i.stringValue
            quotes.append(quote)
            print(quotes)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the news feed",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil) }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    var index = 0 //for some reason, declaring the variable here makes it work...
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let source = quotes[indexPath.row]
            cell.textLabel!.text = quotes[index]
            cell.detailTextLabel?.text = quotes[index]
        index += 1
        return cell
    }
    
    @IBAction func onTappedDoneButton(_ sender: Any) {
        exit(0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        let index = tableView.indexPathForSelectedRow?.row
    }
}
