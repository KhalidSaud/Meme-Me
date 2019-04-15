//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by KHALID ALSUBAIE on 13/04/2019.
//  Copyright © 2019 Arabic Technologies. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var memes: [Meme] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        memes = appDelegate.memes
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memes = appDelegate.memes
        
        let space:CGFloat = 4.0
        let dimensions = (view.frame.width - (2 * space )) / 4.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimensions, height: dimensions)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCellId", for: indexPath) as! CollectionViewCell
        
        let label = memes[indexPath.row].topText + " " + memes[indexPath.row].bottomText
        let image = memes[indexPath.row].memeImage

        cell.cellLabel?.text = label
        cell.cellImage?.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailVC") as! DetailVCViewController
        detailController.image = memes[(indexPath as NSIndexPath).row].memeImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
