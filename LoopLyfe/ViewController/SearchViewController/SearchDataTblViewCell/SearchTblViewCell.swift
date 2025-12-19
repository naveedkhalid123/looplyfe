//
//  SearchTblViewCell.swift
//  LoopLyfe
//
//  Created by iMac on 19/12/2025.
//

import UIKit

class SearchTblViewCell: UITableViewCell {
  
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    
    private var videosArr = ["placeholder", "placeholder", "placeholder","placeholder", "placeholder", "placeholder",]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.backgroundColor = .red
        videosCollectionView.register(UINib(nibName: "VideosCollectionView", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionView")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

// MARK: - Collection View Setup
extension SearchTblViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
        cell.videosImageView.image = UIImage(named: videosArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: 127)
    }
    
    
}
