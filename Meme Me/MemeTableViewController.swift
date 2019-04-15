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
    
    var tempImage: UIImage?
    
   // var detailVC =
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = 120.0
        
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if memes.count == 0 {
            print("No Memes")
        }
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCellId")
        
        cell!.imageView?.image = memes[indexPath.row].memeImage
        cell!.textLabel?.text = memes[indexPath.row].topText + " " + memes[indexPath.row].bottomText
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // tableView.deselectRow(at: indexPath, animated: true)
        
        tempImage = memes[indexPath.row].memeImage
        print("memeimage")
        print(memes[indexPath.row].memeImage)
        print("temp")
        print(tempImage)
        performSegue(withIdentifier: "TableToDetail", sender: self)
        
        
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVCViewController
//        detailController.image = memes[indexPath.row].memeImage
//        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "TableToDetail") {
            let detailVC = segue.destination as! DetailVCViewController
            detailVC.image = tempImage
            print("detailvc")
            print(detailVC.image!)
            
            
        }
        
        
    }
    
}
