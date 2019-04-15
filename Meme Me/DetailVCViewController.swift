//
//  DetailVCViewController.swift
//  Meme Me
//
//  Created by KHALID ALSUBAIE on 15/04/2019.
//  Copyright © 2019 Arabic Technologies. All rights reserved.
//

import UIKit

class DetailVCViewController: UIViewController {

    var image: UIImage? = UIImage()
    
    var delegate : DetailVCViewController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        imageView.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
