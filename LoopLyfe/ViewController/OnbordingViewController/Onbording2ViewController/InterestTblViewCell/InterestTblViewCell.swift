//
//  InterestTblViewCell.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 14/02/2025.
//

import UIKit

class InterestTblViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var interestArr = ["Daily Life","Comedy","Entertainment","Animals","Food","Beauty & Style","Drama","Learning","Talent","Sports","Auto","Family","Fitness & Health","DIY & Life Hacks","Arts & Crafts","Dance","Outdoors"]
   

    @IBOutlet weak var interestLbl: UILabel!
    @IBOutlet weak var interestCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        interestCollectionView.register(UINib(nibName: "InterestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InterestCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        cell.interestLbl.text = interestArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 55)
    }
    

}
