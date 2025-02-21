//
//  ShareViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 18/02/2025.
//

import UIKit

class ShareViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    var repostImagesArr = [["img":"repost","lbl":"Repost"],["img":"greyProfile","lbl":"Naveed"],["img":"greyNext","lbl":"More"],]
    
    var messagesImagesArr = [["img":"message 1","lbl":"Message"],["img":"copy","lbl":"Copy link"],["img":"SMS","lbl":"SMS"],["img":"email","lbl":"Email"],["img":"facebook","lbl":"Facebook"],]
    
    var reportImagesArr = [["img":"report","lbl":"Report"],["img":"NoInterest","lbl":"Not Interested"],["img":"duet","lbl":"Duet"],["img":"stitch","lbl":"Stitch"],["img":"ToFavourite","lbl":"Add to favourites"],]
    
    @IBOutlet weak var repostCollectionView: UICollectionView!
    @IBOutlet weak var messgaeCollectionView: UICollectionView!
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repostCollectionView.delegate = self
        repostCollectionView.dataSource = self
        repostCollectionView.register(UINib(nibName: "RepostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepostCollectionViewCell")
        
        messgaeCollectionView.delegate = self
        messgaeCollectionView.dataSource = self
        messgaeCollectionView.register(UINib(nibName: "RepostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepostCollectionViewCell")
        
        reportCollectionView.delegate = self
        reportCollectionView.dataSource = self
        reportCollectionView.register(UINib(nibName: "RepostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RepostCollectionViewCell")
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == repostCollectionView {
            return repostImagesArr.count
        } else if collectionView == messgaeCollectionView {
            return messagesImagesArr.count
        } else {
            return reportImagesArr.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == repostCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepostCollectionViewCell", for: indexPath) as! RepostCollectionViewCell
            cell.repostImage.image = UIImage(named: repostImagesArr[indexPath.row]["img"] ?? "")
            cell.repostLbl.text = repostImagesArr[indexPath.row]["lbl"]
            return cell
        }  else if collectionView == messgaeCollectionView  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepostCollectionViewCell", for: indexPath) as! RepostCollectionViewCell
            cell.repostImage.image = UIImage(named: messagesImagesArr[indexPath.row]["img"] ?? "")
            cell.repostLbl.text = messagesImagesArr[indexPath.row]["lbl"]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RepostCollectionViewCell", for: indexPath) as! RepostCollectionViewCell
            cell.repostImage.image = UIImage(named: reportImagesArr[indexPath.row]["img"] ?? "")
            cell.repostLbl.text = reportImagesArr[indexPath.row]["lbl"]
            return cell
        }
   
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == repostCollectionView {
            return CGSize(width: collectionView.frame.width / 6, height: 90)
        } else if collectionView == messgaeCollectionView  {
            return CGSize(width: collectionView.frame.width / 6, height: 90)
        } else {
            return CGSize(width: collectionView.frame.width / 6, height: 90)
        }
    }

}
