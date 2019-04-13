//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by KHALID ALSUBAIE on 13/04/2019.
//  Copyright © 2019 Arabic Technologies. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //    var memes: [Meme] = []
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let tableView : UITableViewController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.tableView.reloadInputViews()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if memes.count == 0 {
            print("No Memes")
        }
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "")
        let cell = UITableViewCell()
        let meme = memes[indexPath.row]
        
        cell.imageView?.image = meme.memeImage
        cell.textLabel?.text = memes[indexPath.row].topText + " ... " + memes[indexPath.row].bottomText
        
        
        return cell
    }
    
    
}
